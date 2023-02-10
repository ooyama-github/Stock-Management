class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = current_customer
    @items = @customer.items.page(params[:page]).reverse_order
    @today_item =  @items.created_today
    @yesterday_item = @items.created_yesterday
    @this_week_item = @items.created_this_week
    @last_week_item = @items.created_last_week
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to  customers_mypage_path, notice: "変更内容を保存しました!"
    else
      render 'edit'
    end
  end


  def unsubscribe
    @customer = current_customer
  end


  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, alert: "～退会が完了しました、ご利用ありがとうございました～"
  end

  private
    def customer_params
       params.require(:customer).permit(:email, :name, :profile_image)
    end

    #ゲストユーザーの記述
    def ensure_guest_customer
      @customer = current_customer
      if @customer.name == "guestuser"
      redirect_to customers_mypage_path(current_customer), notice: 'ゲストユーザーはプロフィール画面へ遷移できません。'
      end
    end
end