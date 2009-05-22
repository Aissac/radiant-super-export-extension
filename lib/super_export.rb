unless defined?(Radiant::ExtensionMeta)
  class Radiant::ExtensionMeta < ActiveRecord::Base
    set_table_name 'extension_meta'
  end
end

unless defined?(SchemaMigration)
  class SchemaMigration < ActiveRecord::Base
    def id
      version.underscore.gsub(/[^1-9a-z_]/, '_')
    end
  end
end

module SuperExport
  EXPORT_ROOT = "#{RAILS_ROOT}/db/export"
  
  # In most cases singularizing a table's name yields the model's name but in
  # special cases where the model's name is already seen as plural by rails, it
  # expects the table's name to then also be plural (so the model: 'MyData' goes
  # with the table: 'my_data')
  def self.models
    tables = ActiveRecord::Base.connection.tables
    tables.delete "config"
    models = tables.collect { |table| table.camelize.singularize.constantize rescue nil || table.camelize.constantize rescue nil}.compact
    models << Radiant::Config
    models << Radiant::ExtensionMeta
  end
  
  module SharedMethods
    def logger
      RAILS_DEFAULT_LOGGER
    end
    
    def model_export_root
      File.join(EXPORT_ROOT, model.table_name)
    end
    
    def export_filepath_for(record)
      File.join(model_export_root, "#{record.id}.yml")
    end
  end
end