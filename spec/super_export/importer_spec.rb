require File.dirname(__FILE__) + '/../spec_helper'

describe SuperExport::Importer do
  before do
    @record = stub_model(Page, :create => true)
    
    @importer = SuperExport::Importer.new(Page)
    @importer.stub!(:model_export_root).and_return('/page_export_root')
    
    Dir.stub!(:[]).and_return("/page_export_root/1.yml")
    YAML.stub!(:load_file).and_return(@record)
  end
  
  it "globs YAML files in model export root" do
    Dir.should_receive(:[]).with("/page_export_root/*.yml").and_return([])
    @importer.import
  end
  
  it "loads all records from YAML files" do
    Dir.stub!(:[]).and_return((1..10).map { |i| "/page_export_root/#{i}.yml" })
    
    (1..10).each do |i|
      YAML.should_receive(:load_file).with("/page_export_root/#{i}.yml").and_return(@record)
    end
    
    @importer.import
  end
  
  it "creates the record loaded from YAML" do
    @record.should_receive(:create)
    @importer.import
  end
  
  it "correctly saves salt and password for User" do
    @record = stub_model(User, :create => true, :id => 1, :password => 'secret', :salt => 'marine')
    YAML.stub!(:load_file).and_return(@record)
    User.should_receive(:update_all).
      with({:password => 'secret', :salt => 'marine'}, ['id = ?', @record])
    @importer.import
  end
  
  it "does not record timestamps" do
    Page.record_timestamps.should be_false
  end
end
