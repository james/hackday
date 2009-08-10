require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DataSource do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :link => "value for link",
      :description => "value for description",
      :category => "value for category"
    }
  end

  it "should create a new instance given valid attributes" do
    DataSource.create!(@valid_attributes)
  end
end
