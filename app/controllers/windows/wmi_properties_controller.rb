class Windows::WmiPropertiesController < ApplicationController
  before_filter :define_criteria, :class_parameter
  
  def show
    @property = @kriteria.find(params[:id])
  end

  def index 
    @properties = @kriteria.all
  end

  def new
    logger.debug "criteria => #{@kriteria}"
    @property = @kriteria.new
  end
  
  def create
    @property = @kriteria.new(params[:windows_wmi_property])
    if @property.save
      redirect_to windows_properties_path(@class_parameter)
    else
      render :action => :new
    end
  end

  def edit
    @property = @kriteria.find(params[:id])
  end
  
  def update
    @property = @kriteria.find(params[:id])
    if @property.update_attributes(params[:windows_wmi_property])
      redirect_to windows_properties_path(@class_parameter)
    else
      render :action => :edit
    end
  end
  
  def destroy
    @property = @kriteria.find(params[:id])
    @property.destroy
    redirect_to windows_properties_path(@class_parameter)
  end
  
  protected
    def define_criteria
      @class = Windows::WmiClass.find(params[:class]) if params[:class]
      @kriteria = @class.present? ? @class.properties : Windows::WmiProperty
    end
    
    def class_parameter
      @class_parameter = @class.present? ? {:class => @class.id} : {}
    end
  
end
