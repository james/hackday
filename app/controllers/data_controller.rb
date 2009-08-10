class DataController < ApplicationController
  def index
    @data_sources = DataSource.find(:all, :group => "category")
  end
  
  def new
    @data_source = DataSource.new
  end
  
  def create
    @data_source = DataSource.new(params[:data_source])
    if @data_source.save
      redirect_to data_sources_path
    else
      render :action => "new"
    end
  end
end
