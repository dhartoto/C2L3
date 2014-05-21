class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(set_comment)
    @comment.creator = User.first # TODO: Change to current user
    @comments = @post.comments.all
    if @comment.save
      flash[:notice] = "Your comment has been posted"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  private

  def set_comment
    params.require(:comment).permit(:body)
  end

end