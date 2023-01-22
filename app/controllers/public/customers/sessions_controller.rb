class Public::Customers::SessionsController < ApplicationController
  # ゲストログイン
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to items_path, notice: 'guestcustomerでログインしました。'
  end
end
