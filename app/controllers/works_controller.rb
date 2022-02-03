class WorksController < ApplicationController
  # ログイン機能を作ってから精査
  skip_before_action :require_login

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
    @today_words = Word.today_three_words
  end

  def create
    @work = current_user.works.new(work_params)
    @today_words = Word.today_three_words
    if @work.save
      @today_words.each do |tw|
        @work.random_words.create!(word_id: tw.id)
      end
      redirect_to works_path, notice: '小説を投稿しました'
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
