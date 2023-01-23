class Admin::ItemsController < ApplicationController
  
  before_action :authenticate_admin!
  # メニュー一覧
  def index
    @items = Item.page(params[:page]).per(5)
  end
  # メニュー新規登録画面
  def new
    @item = Item.new
    @genres = Genre.all
  end
  # メニュー情報の新規登録
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "メニューが保存されました。"
      redirect_to admin_item_path(@item.id)
    else
      @genres = Genre.all
      render :new
    end
  end
  # メニュー詳細
  def show
    @item = Item.find(params[:id])
  end
  # メニュー編集
  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  # メニュー更新
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "メニューを更新しました。"
      redirect_to admin_item_path(@item.id)
    else
      @genres = Genre.all
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :calorie, :allergy, :price, :is_active, :image)
  end

end
