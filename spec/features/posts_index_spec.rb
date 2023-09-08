require 'rails_helper'

describe 'User Index Page Features', type: :feature do
  before :each do
    @user1 = User.create(
      name: 'yousef',
      photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
      bio: 'I am a user1',
      posts_counter: 5
    )

    post1 = Post.create(id: 4, title: 'Post 1', text: 'text 1', likes_counter: 0, comments_counter: 0,
                        author_id: @user1.id)
    post2 = Post.create(id: 5, title: 'Post 2', text: 'text 2', likes_counter: 0, comments_counter: 0,
                        author_id: @user1.id)
    Post.create(id: 6, title: 'Post 3', text: 'text 3', likes_counter: 0, comments_counter: 0, author_id: @user1.id)
    Post.create(id: 7, title: 'Post 4', text: 'text 4', likes_counter: 0, comments_counter: 0, author_id: @user1.id)

    @user1.comments.create(text: 'This is comment 1', post: post1)
    @user1.comments.create(text: 'This is comment 2', post: post1)
    @user1.comments.create(text: 'This is comment 3', post: post2)

    @user1.likes.create(post: post1)
  end

  it 'displays the user\'s profile picture' do
    visit user_posts_path(@user1)
    expect(page).to have_css("img[src*=\"#{@user1.photo}\"]")
  end

  it 'displays the user\'s username' do
    visit user_posts_path(@user1)
    expect(page).to have_content('yousef')
  end

  it 'displays the number of posts the user has written' do
    visit user_posts_path(@user1)
    expect(page).to have_content('Posts')
  end

  it 'displays a list of posts' do
    # Create some posts for the user and visit the user's posts page
    # Then, check if the posts are displayed on the page
    visit user_posts_path(@user1)
    expect(page).to have_content('Post 1')
    expect(page).to have_content('Post 2')
    # Add more expectations for other posts as needed
  end

  it 'redirects to a post\'s show page when clicked' do
    # Create a post and visit the user's posts page
    # Then, click on a post and check if it redirects to the post's show page
    visit user_posts_path(@user1)
    click_link('Post 1')
    expect(page).to have_current_path(user_post_path(@user1, 4))
  end
end
