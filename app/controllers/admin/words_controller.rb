class Admin::WordsController < Admin::BaseController
  def index
    @words = Word.all.order(id: :desc).page params[:page]
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      redirect_to admin_words_path, success: '単語登録が完了しました'
    else
      flash.now[:error] = '単語登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @word = Word.find(params[:id])
  end

  def show
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])
    if @word.update(word_params)
      redirect_to admin_words_path, success: '単語編集が完了しました'
    else
      flash.now[:error] = '単語編集に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy!
    redirect_to admin_words_path, success: '単語削除が完了しました'
  end

  private

  def word_params
    params.require(:word).permit(:name)
  end
end
