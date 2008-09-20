module SuperExport
  EXPORT_ROOT = "#{RAILS_ROOT}/db/export"
  
  def self.models
    tables = ActiveRecord::Base.connection.tables
    tables.delete "config"
    models = tables.collect { |table| table.camelize.singularize.constantize rescue nil}.compact
    models << Radiant::Config
    models << Radiant::ExtensionMeta
  end
  
  module SharedMethods
    def model_export_root
      File.join(EXPORT_ROOT, model.table_name)
    end
    
    def export_filepath_for(record)
      File.join(model_export_root, "#{record.id}.yml")
    end
  end
end