namespace :db do
  desc "Export models"
  task :super_export do
    require 'highline/import'
    if ENV['OVERWRITE'].to_s.downcase == 'true' or agree("This task will erase previous exports and schema.rb. Are you sure you want to \ncontinue? [yn] ")
      Rake::Task["db:schema:dump"].invoke
      SuperExport::Exporter.export
    else
      say "Task cancelled."
      exit
    end
    
  end
  
  desc "Import models"
  task :super_import do
    require 'highline/import'
    if ENV['OVERWRITE'].to_s.downcase == 'true' or agree("This task will overwrite any data in the database. Are you sure you want to \ncontinue? [yn] ")
      Rake::Task["db:schema:load"].invoke
      SuperExport::Importer.import
    else
      say "Task cancelled."
      exit
    end
  end
end