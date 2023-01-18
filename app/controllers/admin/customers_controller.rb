class Admin::CustomersController < ApplicationController
  # 管理者側でログインしていない場合、ログイン画面へ遷移
  before_action :authenticate_admin!

  def index
    @admin_customers = Customer.page(params[:page])
  end

  def show
    @admin_customer = Customer.find(params[:id])
  end

  def edit
    @admin_customer = Customer.find(params[:id])
  end

  def update
    @admin_customer = Customer.find(params[:id])
    if @admin_customer.update(admin_customer_params)
      flash[:notice] = "情報の変更が完了しました！"
      redirect_to admin_customer_path(@admin_customer.id)
    else
      flash[:alert] = "保存に失敗しました。"
      render :edit
    end
  end

  private
  def admin_customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end
end
