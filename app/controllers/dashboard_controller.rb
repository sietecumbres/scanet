class DashboardController < ApplicationController
  before_filter :require_current_user
  
  def index
  end

end
