class Admin::UserSessionsController < Admin::BaseController
  layout 'admin/layouts/login'
  skip_before_action :require_login, only: %i[new create]

  def new;end

  def create
    @user = login(params[:penname], params[:password])

    if @user
      redirect_to admin_dashboard_path
    else
      flash.now[:error] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, status: :see_other
  end
end
