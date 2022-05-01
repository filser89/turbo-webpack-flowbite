class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show]

  def show
    @products = @user.products.page(1).per(5)
    @orders = @user.orders.page(1).per(5)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
