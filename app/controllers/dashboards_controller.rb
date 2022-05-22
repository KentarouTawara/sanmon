class DashboardsController < ApplicationController
  def show
    @works = current_user.works.order(id: :desc).page params[:page]
  end
end
