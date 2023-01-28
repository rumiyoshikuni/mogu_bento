class Admin::HomesController < ApplicationController
  
  before_action :authenticate_admin!
  # 管理者トップページ(予約注文履歴一覧)、order(created_at: :desc)：最新の予約注文を１番最初に表示
  def top
    @pre_orders = PreOrder.order(created_at: :desc).page(params[:page]).per(10)
  end
  
end
