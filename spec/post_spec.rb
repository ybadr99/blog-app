require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0)
  end

  it "is valid with valid attributes" do
    post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = Post.create(author_id: @user.id, text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end


  it "returns correct number of recent comments" do
    post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    comment1 = Comment.create(author_id: @user.id, post_id: post.id, text: 'Comment 1')
    comment2 = Comment.create(author_id: @user.id, post_id: post.id, text: 'Comment 2')
    comment3 = Comment.create(author_id: @user.id, post_id: post.id, text: 'Comment 3')

    recent_comments = post.recent_comments(2)
    expect(recent_comments).to eq([comment3, comment2])
  end

  it "updates the author's posts_counter when saved" do
      expect {
        Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
      }.to change { @user.reload.posts_counter }.by(1)
    end
    
end
