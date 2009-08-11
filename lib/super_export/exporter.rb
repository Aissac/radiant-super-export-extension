# Patch for YAML correct export of multiline strings where:
#  * The string begins with a newline character
#  * The first non-empty line begins with an indent
#  * At least one successive line begins without this same indent
#
# Read more: http://blog.smartlogicsolutions.com/2008/09/04/ruby-patch-to-fix-broken-yamldump-for-multi-line-strings-stringto_yaml/
class String
  alias :old_to_yaml :to_yaml
  def to_yaml(options={})
    if self =~ /^[\n\r]/
      " #{self}".old_to_yaml(options)
    else
      old_to_yaml(options)
    end
  end
end

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