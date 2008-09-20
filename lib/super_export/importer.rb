module SuperExport
  class Importer
    include SharedMethods
    
    def self.import
      SuperExport.models.each do |model|
        Importer.new(model).import
      end
    end
    
    attr_reader :model
    
    def initialize(model)
      @model = model
    end
    
    def import
      files = Dir["#{model_export_root}/*.yml"]
      puts "Importing #{model} (#{files.size} found)"
      
      files.each do |file|
        record = YAML.load_file(file)
        capture_user(record) do
          record.instance_variable_set(:@new_record, true)
          record.save(false)
        end
      end
    end
    
    def capture_user(record, &block)
      if record.is_a?(User)
        password = record.password
        salt = record.salt
      end
      
      yield
      
      User.update_all({:password => password, :salt => salt}, ['id = ?', record]) if record.is_a?(User)
    end
  end
end