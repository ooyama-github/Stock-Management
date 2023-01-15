class Admin::CustomersController < ApplicationController
  # 管理者側でログインしていない場合、ログイン画面へ遷移
  before_action :authenticate_admin!
  
  def index
    @admin_customers = Customer.all
  end
  
  def show
    @admin_customer = Customer.find(params[:id])
  end
  
  def edit
    @admin_customer = Customer.find(params[:id])
  end
  
  def update
  end
  
  private
  def admin_customer_params
    params.require(:customer).permit(:name, :email)
  end
end
