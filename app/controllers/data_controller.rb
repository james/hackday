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
  
  def edit
    @data_source = DataSource.find(params[:id])
  end
  
  def update
    @data_source = DataSource.find(params[:id])
    if @data_source.update_attributes(params[:data_source])
      redirect_to data_sources_path
    else
      render :action => "edit"
    end
  end
  
  def delete
    edit
  end
  
  def destroy
    DataSource.find(params[:id]).destroy
    redirect_to data_sources_path
  end
  
end
