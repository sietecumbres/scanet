class Windows::WmiClassesController < ApplicationController
  before_filter :define_criteria, :namespace_parameter
  
  def show
    @class = @kriteria.find(params[:id])
  end

  def index 
    @classes = @kriteria.all
    logger.debug "namespace => #{@namespace_parameter}"
  end

  def new
    @class = @kriteria.new
  end
  
  def create
    @class = @kriteria.new(params[:windows_wmi_class])
    if @class.save
      redirect_to windows_classes_path(@namespace_parameter)
    else
      render :action => :new
    end
  end

  def edit
    @class = @kriteria.find(params[:id])
  end
  
  def update
    @class = @kriteria.find(params[:id])
    if @class.update_attributes(params[:windows_wmi_class])
      redirect_to windows_classes_path(@namespace_parameter)
    else
      render :action => :edit
    end
  end
  
  def destroy
    @class = @kriteria.find(params[:id])
    @class.destroy
    redirect_to windows_classes_path(@namespace_parameter)
  end
  
  protected
    def define_criteria
      @namespace = Windows::WmiNamespace.find(params[:namespace]) if params[:namespace]
      @kriteria = @namespace.present? ? @namespace.classes : Windows::WmiClass
    end
    
    def namespace_parameter
      @namespace_parameter = @namespace.present? ? {:namespace => @namespace.id} : {}
    end

end
