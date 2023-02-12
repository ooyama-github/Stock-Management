class Public::GraphsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @items = Item.where(customer_id: current_customer.id).page(params[:item_pagenate])
    # 今日、昨日、一週間の投稿数を一覧表示させるための変数定義
    @today_item =  @items.created_today
    @yesterday_item = @items.created_yesterday
    @this_week_item = @items.created_this_week
    @last_week_item = @items.created_last_week

    # 過去 7 日分の投稿数グラフ化するための変数定義
    #@item_by_day = @items.group_by_day(:created_at).size
    @item_by_day = @items.select('date(created_at) as create_date, count(id) as count').group('date(created_at)').size
    # groupdateのselectメソッドで投稿日(created_at)に基づくグルーピングして個数計上。
    # => {Wed, 05 May 2021=>23, Thu, 06 May 2021=>20, Fri, 07 May 2021=>3, Sat, 08 May 2021=>0, Sun, 09 May 2021=>12, Mon, 10 May 2021=>2}

    @chartlabels = @item_by_day.map(&:first).to_json.html_safe
    # 投稿日付の配列を格納。文字列を含んでいると正しく表示されないので.to_json.html_safeでjsonに変換。
    # => "[\"2021-05-05\",\"2021-05-06\",\"2021-05-07\",\"2021-05-08\",\"2021-05-09\",\"2021-05-10\"]"
    # ここで言うfirstは配列の１番目つまり日付

    @chartdatas = @item_by_day.map(&:second)
    # 日別投稿数の配列を格納。
    # => [23, 20, 3, 0, 12, 2]
    # ここで言うsecondは配列の2番目つまり投稿数
  end
end
