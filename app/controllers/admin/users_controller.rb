class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.order(id: :desc).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email = SecureRandom.hex(8)
    if @user.save
      redirect_to admin_users_path, success: 'ユーザー登録が完了しました'
    else
      flash.now[:error] = 'ユーザー登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: 'ユーザー情報の更新が完了しました'
    else
      flash.now[:error] = 'ユーザー情報の更新に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to admin_users_path, success: 'ユーザー削除が完了しました'
  end

  private

  def user_params
    params.require(:user).permit(:penname, :password, :password_confirmation)
  end
end
