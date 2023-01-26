class Public::GenresController < ApplicationController
  before_action :authenticate_customer!

  def index
    @genres = Genre.where(customer_id: current_customer.id).page(params[:page]).per(7)
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.customer_id = current_customer.id
    @genre.save!
    redirect_to genres_path, notice: "#{@genre.name}を追加しました!"
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path, notice: "#{@genre.name}を更新しました!"
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to genres_path, alert: "#{@genre.name}を削除しました!"
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
