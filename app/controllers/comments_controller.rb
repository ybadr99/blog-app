class CommentsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_comment, only: [:destroy]


  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    render 'new'
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])

    @comment = Comment.new(
      text: params[:text],
      author_id: @user.id,
      post_id: @post.id
    )

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment created successfully.'
    else
      render 'new'
    end
  end

  def destroy
    authorize! :destroy, @comment # Check if user can delete the comment

    if @comment.destroy
      redirect_to user_post_path(@comment.post.author, @comment.post), notice: 'Comment deleted successfully.'
    else
      redirect_to user_post_path(@comment.post.author, @comment.post), alert: 'Failed to delete the comment.'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
