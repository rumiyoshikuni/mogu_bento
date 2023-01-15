class Admin::HomesController < ApplicationController
  
  def top
    @pre_orders = PreOrder.page(params[:page])
  end
  
end
