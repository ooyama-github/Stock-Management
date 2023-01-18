class Public::GenresController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @genres = Genre.page(params[:page])
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path
    else
      render :edit
    end
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
