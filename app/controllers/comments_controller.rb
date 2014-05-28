class CommentsController < ApplicationController
  before_action :require_user, except: [:index, :show,]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(set_comment)
    @comment.post = @post 
    @comment.creator = current_user
    @comments = @post.comments.all.sort_by{|x| x.count_votes}
    if @comment.save
      flash[:notice] = "Your comment has been posted"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(vote: params[:vote], voteable: @comment, creator: current_user)
    if !@vote.valid?
      flash[:error] = "You can only vote once per comment."
    end
    redirect_to :back
  end

  private

  def set_comment
    params.require(:comment).permit(:body)
  end
end