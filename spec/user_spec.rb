require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(name: 'John Doe', posts_counter: 0)
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(posts_counter: 0)
    expect(user).not_to be_valid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid with a negative posts counter' do
    user = User.new(name: 'Jane Smith', posts_counter: -1)
    expect(user).not_to be_valid
    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end

  it 'returns correct number of recent posts' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)
    recent_posts = user.recent_posts
    expect(recent_posts.count).to eq(3)
  end
end
