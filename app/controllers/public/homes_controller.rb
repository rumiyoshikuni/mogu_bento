class Public::HomesController < ApplicationController
  
  def top
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: 1).page(params[:page]).per(4)
    else
      @items = Item.where(is_active: 1).page(params[:page]).per(4)
    end
  end
  
  def about
  end
  
end
