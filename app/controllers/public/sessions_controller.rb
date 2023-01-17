# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_customer, only: [:create]

  protected
  # 退会しているか判断するメソッド
  def reject_customer
  # 【処理内容１】　入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    # 【処理内容２】取得したアカウントのパスワードと入力されたパスワードが一致しているかを判別
    if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
      # 【処理内容３】退会しているかの判別
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_customer_registration_path
    end
  end
  
  # ゲストログインの記述
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'guestuserでログインしました。'
  end
end


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
