class Admin::HomesController < ApplicationController
  
  before_action :authenticate_admin!
  
  def top
    @pre_orders = PreOrder.page(params[:page]).per(10)
  end
  
end
