class Public::ItemsController < ApplicationController


  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to items_path
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to items_path(item.id)
  end

  # ストロングパラメータ
  private
    def item_params
      params.require(:item).permit(:image, :name, :Purchase_amount, :Sale_amount, :Date_of_purchase, :genre_id, :memo, :quantity)
    end

end

