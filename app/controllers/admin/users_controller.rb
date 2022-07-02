class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def create
  end

  def new
  end

  def show
  end

  def update
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
  end
end
