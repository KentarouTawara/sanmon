class ApplicationController < ActionController::Base
  add_flash_types :info, :success, :error, :warning
  before_action :require_login

  def not_authenticated
    redirect_to login_path, alert: 'ログインしてください'
  end
end
