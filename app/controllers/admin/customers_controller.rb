class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!
  # 会員一覧
  def index
    @customers = Customer.page(params[:page]).per(10)
  end
  # 会員詳細
  def show
    @customer = Customer.find(params[:id])
  end
  # 会員編集
  def edit
    @customer = Customer.find(params[:id])
  end
  # 会員情報の更新
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を編集しました。"
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :tel_number, :email, :is_deleted)
  end

end
