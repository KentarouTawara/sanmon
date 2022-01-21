class WorksController < ApplicationController
  # ログイン機能を作ってから精査
  skip_before_action :require_login
  def index
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to root_path, notice: '小説を投稿しました'
    else
      flash.now[:danger] = '小説投稿に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :content)
  end
end
