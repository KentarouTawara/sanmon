class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @work = @comment.work

    if @comment.save
      render :create
    else
      # TODO:redirect_to ではおかしい work_controller#showをレンダリングするべき
      # redirect_to work_path(@comment.work), status: :unprocessable_entity, error: 'コメントが更新できません'
      render 'works/show', status: :unprocessable_entity, error: 'コメントが作成できません'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @work = @comment.work
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @work = @comment.work
    if @comment.update(update_params)
      redirect_to work_path(@comment.work)
    else
      # エラーメッセージが出現しない謎。
      render :edit, error: 'コメントが更新できません', status: :unprocessable_entity
    end
  end

  def destroy
    # ココの挙動はあまり理解していない
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    render turbo_stream: turbo_stream.remove(@comment), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(work_id: params.require(:work_id))
  end

  def update_params
    params.require(:comment).permit(:body)
  end
end
