module SuperExport
  class Exporter
    include SharedMethods
    
    def self.export
      SuperExport.models.each do |model|
        Exporter.new(model).export
      end
    end
  
    attr_reader :model
  
    def initialize(model)
      @model = model
    end
  
    def export
      puts "Exporting #{model} (#{model.count(:all)} records)"
      
      FileUtils.makedirs(model_export_root) unless File.directory?(model_export_root)
      FileUtils.rm(Dir["#{model_export_root}/*.yml"])
    
      model.find(:all).each do |record|
        File.open(export_filepath_for(record), 'w') { |f| f.write(record.to_yaml) }
      end
    end
  end
end