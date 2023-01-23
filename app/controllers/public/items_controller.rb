class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!, except: [:index]
  # メニュー一覧
  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: 1).page(params[:page]).per(8)
    else
      @items = Item.where(is_active: 1).page(params[:page]).per(8)
    end
  end
  # メニュー詳細
  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
