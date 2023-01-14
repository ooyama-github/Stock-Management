class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!, except: [:edit, :index, :new, :show]

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
    @items = Item.page(params[:page])
    @items = Item.all
    # ジャンル検索のための記述
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
    elsif @search_items
      @items = @search_items.page(params[:page])
      @items_count = @search_items.all.count
    end
  end

  def create
    @item = Item.new(item_params)
    # フラッシュメッセージを
    if @item.save
      flash[:notice] = "商品の新規登録に成功しました!"
      # 一覧ページに移動
      redirect_to items_path
    #うまく登録できなかった場合は新規登録画面に移動
    else
      render :new
    end
  end

  def update
    @item = Item.find(params[:id])
    # フラッシュメッセージを設定
    if @item.update(item_params)
      flash[:notice] = "商品は編集されました！"
      redirect_to items_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end


  # ストロングパラメータ
  private
    def item_params
      params.require(:item).permit(:image, :name, :Purchase_amount, :Sale_amount, :Date_of_purchase, :genre_id, :memo)
    end

end

