class Admin::BaseController < ApplicationController
  layout 'admin/layouts/application'
  before_action :require_login

  def not_authenticated
    redirect_to admin_login_path, alert: 'ログインしてください'
  end
end