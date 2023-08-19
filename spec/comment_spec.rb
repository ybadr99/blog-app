require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    @post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
  end

  it 'is valid with valid attributes' do
    comment = Comment.create(author_id: @user.id, post_id: @post.id, text: 'Great post!')
    expect(comment).to be_valid
  end

  it 'is invalid without text' do
    comment = Comment.create(author_id: @user.id, post_id: @post.id, text: '')
    expect(comment).not_to be_valid
    expect(comment.errors[:text]).to include("can't be blank")
  end

  it "updates the post's comments_counter when saved" do
    expect do
      Comment.create(author_id: @user.id, post_id: @post.id, text: 'Great post!')
    end.to change { @post.reload.comments_counter }.by(1)
  end
end
