class DashboardsController < ApplicationController
  def show
    @works = current_user.works.order(id: :desc)
  end
end
