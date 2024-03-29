class WorksController < ApplicationController
  # ログイン機能を作ってから精査
  skip_before_action :require_login, only: %i[index new create show]

  def index
    @works = Work.includes(:user, :three_words).order(id: :desc).page params[:page]
  end

  def new
    @work = Work.new
    @today_words = Word.today_three_words
  end

  def create
    if current_user.nil?
      # TODO: シードデータを参照するように変更
      gest_user = User.first
      @work = gest_user.works.new(work_params)
    else
      @work = current_user.works.new(work_params)
    end
    @today_words = Word.today_three_words
    if @work.save
      @today_words.each do |tw|
        @work.random_words.create!(word_id: tw.id)
      end
      auto_tweet(@work)
      redirect_to works_path, success: '小説を投稿しました'
    else
      flash.now[:error] = '小説投稿に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @work = Work.find(params[:id])
    @three_words = @work.three_words
    @comment = Comment.new
    @comments = @work.comments
  end

  def edit
    @work = current_user.works.find(params[:id])
  end

  def update
    @work = current_user.works.find(params[:id])

    if @work.update(work_params)
      redirect_to work_path(@work), success: '小説を更新しました'
    else
      flash.now[:error] = '小説の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    work = current_user.works.find(params[:id])
    work.destroy!
    redirect_to works_path, success: "小説を削除しました", status: :see_other
  end

  private

  def work_params
    params.require(:work).permit(:title, :content)
  end

  def auto_tweet(work)
    TwitterClient.new.tweet(work)
    TwitterClient.new.create_direct_message(work)
  end
end
