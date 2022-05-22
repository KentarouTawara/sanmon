class AuthorsController < ApplicationController

  def show
    @user = User.find_by(penname: params[:pen_name] )
    @works = @user.works.order(id: :desc).page params[:page]
    @works_count = @works.total_count
  end
end
