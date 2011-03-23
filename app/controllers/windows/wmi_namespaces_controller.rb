class Windows::WmiNamespacesController < ApplicationController
  
  def show
    @namespace = Windows::WmiNamespace.find(params[:id])
  end
  
  def index
    @namespaces = Windows::WmiNamespace.all
  end
  
  def new
    @namespace = Windows::WmiNamespace.new
  end
  
  def create
    @namespace = Windows::WmiNamespace.new params[:windows_wmi_namespace]
    
    if @namespace.save
      redirect_to windows_namespaces_path
    else
      render :action => :new
    end
  end
  
  def edit
    @namespace = Windows::WmiNamespace.find(params[:id])
  end
  
  def update
    @namespace = Windows::WmiNamespace.find(params[:id])
    
    if @namespace.update_attributes(params[:windows_wmi_namespace])
      redirect_to windows_namespaces_path
    else
      render :action => :edit
    end
  end
  
  def destroy
    @namespace = Windows::WmiNamespace.find(params[:id])
    @namespace.destroy
    redirect_to windows_namespaces_path
  end
  
end
