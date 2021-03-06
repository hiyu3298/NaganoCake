class Public::CustomersController < ApplicationController
  def show
    @user = current_customer
  end

  def edit
    @user = current_customer
  end

  def update
    @user = current_customer
    if @user.update(customer_params)
      redirect_to customer_path
    else
      render :exit
    end
  end

  def delete_verification
  end

  def withdraw
    @customer = current_customer

        # is_customer_statusカラムにフラグを立てる(default→false(有効状態)をtrue(無効状態)にする）
        @customer.update(is_customer_status: true)
        flash[:notice] = "退会しました。"
        # ログアウトさせる
        reset_session

        redirect_to root_path
  end


  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :is_customer_status, :email)
  end
end
