require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    @post = Post.create(author_id: @user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
  end

  it 'is valid with valid attributes' do
    like = Like.create(author_id: @user.id, post_id: @post.id)
    expect(like).to be_valid
  end

  it "updates the post's likes_counter when saved" do
    expect do
      Like.create(author_id: @user.id, post_id: @post.id)
    end.to change { @post.reload.likes_counter }.by(1)
  end
end
