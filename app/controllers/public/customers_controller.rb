class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  # before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to  customers_mypage_path
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
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
    def customer_params
       params.require(:customer).permit(:email, :name)
    end

    # def ensure_guest_customer
    #   @customer = Customer.find(params[:id])
    #   ir @customer.name == "guestuser"
    #   redirect_to customer_path(current_customer), notice: 'ゲストユーザーはプロフィール画面へ遷移できません。'
    # end
end