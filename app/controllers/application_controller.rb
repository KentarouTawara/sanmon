class ApplicationController < ActionController::Base
  add_flash_types :info, :success, :error, :warning
  before_action :require_login
end
