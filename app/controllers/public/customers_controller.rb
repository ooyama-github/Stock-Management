class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_customer!
  before_action :ensure_guest_customer, only: [:edit]
  before_action :set_target_customer, only: %i[show edit update unsubscribe withdraw]

  def show
  end

  def edit
  end
  
  def unsubscribe
  end

  def update
    if @customer.update(customer_params)
      redirect_to  customers_mypage_path, notice: "変更内容を保存しました!"
    else
      render 'edit'
    end
  end

  def withdraw
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, alert: "～退会が完了しました、ご利用ありがとうございました～"
  end

  private
    def customer_params
       params.require(:customer).permit(:email, :name, :profile_image)
    end
    
    def ensure_customer
      @customer = Customer.find(params[:id])
      unless @customer_id == current_customer.id
        redirect_to customers_mypage_path
      end
    end
    
    #ゲストユーザーの記述
    def ensure_guest_customer
      @customer = current_customer
      if @customer.name == "guestuser"
      redirect_to customers_mypage_path(current_customer), notice: 'ゲストユーザーはプロフィール画面へ遷移できません。'
      end
    end
    
    def set_target_customer
      @customer = current_customer
    end
end