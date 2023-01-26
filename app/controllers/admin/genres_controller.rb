class Admin::GenresController < ApplicationController
  
  before_action :authenticate_admin!
  # ジャンル一覧
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  # ジャンル登録
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルを追加しました。"
    else
      @genres = Genre.all
      flash[:alert] = "正しい情報を入力してください。"
      render "index"
    end
  end
  # ジャンル編集
  def edit
    @genre = Genre.find(params[:id])
  end
  # ジャンル更新
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンル名を更新しました。"
    else
      flash[:alert] = "ジャンルの更新に失敗しました。"
      render "edit"
    end
  end
  
  private

  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
