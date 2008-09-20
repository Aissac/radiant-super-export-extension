require File.dirname(__FILE__) + '/../spec_helper'

describe SuperExport::Exporter do
  before do
    @page = stub_model(Page)
    
    @exporter = SuperExport::Exporter.new(Page)
    @exporter.stub!(:model_export_root).and_return('/page_export_root')
    
    Page.stub!(:find).and_return([@page])
    
    File.stub!(:directory?).and_return(true)
    File.stub!(:open)
    
    FileUtils.stub!(:makedirs)
    FileUtils.stub!(:rm)
    
    Dir.stub!(:[]).and_return([])
  end
  
  it "creates model export root unless it exists" do
    File.should_receive(:directory?).with('/page_export_root').and_return(false)
    FileUtils.should_receive(:makedirs).with('/page_export_root')
    @exporter.export
  end
  
  it "removes existing YAML files in model export root" do
    Dir.should_receive(:[]).with('/page_export_root/*.yml').and_return(['1.yml'])
    FileUtils.should_receive(:rm).with(['1.yml'])
    @exporter.export
  end

  it "saves each record to a file" do
    pages = (1..10).map { |i| mock_model(Page, :id => i) }
    Page.should_receive(:find).with(:all).and_return(pages)
    
    pages.each do |page|
      File.should_receive(:open).with("/page_export_root/#{page.id}.yml", 'w')
    end
    
    @exporter.export
  end
end