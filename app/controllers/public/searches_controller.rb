class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @range = params[:range]
    @word = params[:word]
    # ページネーションを適用させる
    @items = current_customer.items.where("name LIKE?","%#{@word}%").page(params[:page])
    # ジャンル検索のための記述
    @genres = Genre.where(customer_id: current_customer.id).page(params[:page])
    if params[:genre_id]
      @items = @items.where(genre_id: params[:genre_id])
    end
    if params[:item_status]
     @items = @items.where(item_status: params[:item_status])
    end
    @sale_totals = @items.get_sales_total(current_customer).page(params[:page])
  end


end