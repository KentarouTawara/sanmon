class WorksController < ApplicationController
  # ログイン機能を作ってから精査
  skip_before_action :require_login

  def index
    @works = Work.all.order(id: :desc)
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

  def show
    @work = Work.find(params[:id])
    @three_words = @work.three_words
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = current_user.works.find(params[:id])

    if @work.update(work_params)
      redirect_to work_path(@work), notice: '小説を更新しました'
    else
      flash.now[:danger] = '小説の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    work = current_user.works.find(params[:id])
    work.destroy!
    redirect_to works_path, notice: "小説を削除しました", status: :see_other
  end

  private

  def work_params
    params.require(:work).permit(:title, :content)
  end
end
