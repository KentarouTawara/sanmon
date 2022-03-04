class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email = SecureRandom.hex(8)
    if @user.save
      auto_login(@user)
      redirect_to root_path, success: 'ユーザー登録が完了しました'
    else
      flash.now[:error] = 'ユーザー登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:penname, :password, :password_confirmation)
  end
end
