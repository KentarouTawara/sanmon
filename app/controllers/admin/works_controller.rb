class Admin::WorksController < Admin::BaseController
  def index
    @works = Work.includes(:three_words).all.order(id: :desc).page params[:page]
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
      redirect_to admin_works_path, success: '小説を投稿しました'
    else
      flash.now[:error] = '小説投稿に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @work = Work.find(params[:id])
  end

  def edit
    @work = Work.find(params[:id])
    @three_words = @work.three_words
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to admin_work_path(@work), success: '作品情報の更新が完了しました'
    else
      flash.now[:error] = '作品情報の更新に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy!

    redirect_to admin_works_path, success: '作品を削除しました'
  end

  private

  def work_params
    params.require(:work).permit(:title, :content)
  end
end
