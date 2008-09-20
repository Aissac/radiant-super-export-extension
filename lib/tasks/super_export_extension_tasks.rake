namespace :db do
  desc "Export models to db/export/[table_name]/*.yml"
  task :export => ["db:schema:dump"] do
    SuperExport::Exporter.export
  end
  
  desc "Import models from db/export/[table_name]/*.yml"
  task :import => ["db:schema:load"] do
    SuperExport::Importer.import
  end
end