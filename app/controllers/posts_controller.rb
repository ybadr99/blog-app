class PostsController < ApplicationController
  before_action :find_user

  def index
    posts_query = Post.includes(:author, :comments)
      .order(created_at: :asc)
      .paginate(page: params[:page], per_page: 10)

    @posts = @user ? posts_query.where(author: @user) : posts_query

    Comment.where(post_id: @posts.pluck(:id)).includes(:author)
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @user
    render 'new'
  end

  def create
    user = current_user
    post = Post.new(title: params[:title], text: params[:text], author_id: user.id, comments_counter: 0,
                    likes_counter: 0)
    if post.save
      redirect_to "/users/#{user.id}/posts", notice: 'new post created successfully'
    else
      render 'new'
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
