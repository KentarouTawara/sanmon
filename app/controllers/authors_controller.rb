class AuthorsController < ApplicationController
  skip_before_action :require_login, only: %i[show]

  def show
    @user = User.find_by(penname: params[:pen_name] )
    @works = @user.works.order(id: :desc).page params[:page]
    @works_count = @works.total_count
  end
end
