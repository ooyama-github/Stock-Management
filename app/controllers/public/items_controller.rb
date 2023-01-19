class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def index
    # ページネーションを適用させる
    @items = Item.where(customer_id: current_customer.id).page(params[:page])
    # ジャンル検索のための記述
    @genres = Genre.where(customer_id: current_customer.id).page(params[:page])
    if params[:genre_id]
      @items = @items.where(genre_id: params[:genre_id])
    # elsif @search_items
    #   @items = @search_items.page(params[:page])
    #   @items_count = @search_items.all.count
    end
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    if @item.save
      # 成功したら一覧ページへ
      redirect_to items_path, notice: "#{@item.name}を追加しました"
      #失敗したら新規登録画面へ
    else
      flash.now[:alert] = "追加に失敗しました"
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      # 成功したら一覧ページへ
      redirect_to items_path(@item.id), notice: "#{@item.name}を更新しました"
    else
      # 失敗したら編集ページへ
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, alert: "#{@item.name}を削除しました"
  end


  # ストロングパラメータ
  private
    def item_params
      params.require(:item).permit(:image, :name, :purchase_amount, :sale_amount, :purchased_at, :genre_id, :memo)
    end

end

