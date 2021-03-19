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

  def destroy
    user = Customer.find(params[:id])
    user.destroy
    redirect_to root_path
  end


  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :is_active, :email)
  end
end
