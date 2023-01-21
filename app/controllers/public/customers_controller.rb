class Public::CustomersController < ApplicationController
  
  before_action :authenticate_customer!
  before_action :ensure_guest_customer, only: [:edit, :update]

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:success] = "登録情報を変更しました。"
      redirect_to my_page_customers_path
    else
      render "edit"
    end
  end

  def quit
  end

  def out
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :tel_number, :email)
  end
  
  def ensure_guest_customer
    if current_customer.email == "guest@example.com"
      redirect_to root_path, notice: 'ゲストユーザーはマイページへ遷移できません。'
    end
  end

end
