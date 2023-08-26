class PostsController < ApplicationController
  before_action :find_user

  def index
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
    if @posts.empty?
      redirect_to "/users/#{params[:user_id]}/posts/new"
    else
      render 'index'
    end
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    render 'new'
  end

  def create
    user = current_user
    puts user
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
