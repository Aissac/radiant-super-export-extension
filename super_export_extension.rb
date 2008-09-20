# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SuperExportExtension < Radiant::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/super_export"
  
  # define_routes do |map|
  #   map.connect 'admin/super_export/:action', :controller => 'admin/super_export'
  # end
  
  def activate
    # admin.tabs.add "Super Export", "/admin/super_export", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Super Export"
  end
  
end