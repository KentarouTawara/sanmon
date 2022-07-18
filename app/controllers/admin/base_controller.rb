class Admin::BaseController < ApplicationController
  layout 'admin/layouts/application'
  before_action :require_login
  before_action :check_admin

  def check_admin
    redirect_to admin_login_path, alert: 'ログイン権限がありません' unless current_user.admin?
  end

  def not_authenticated
    redirect_to admin_login_path, alert: 'ログインしてください'
  end
end