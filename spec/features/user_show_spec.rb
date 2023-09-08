require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Doraemon & Nobita', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'Best friends', posts_counter: 12)
    @post = Post.create(title: 'Physics', text: 'This is not my first post', comments_counter: 10, likes_counter: 10,
                        author: @user)
  end

  describe 'User show page' do
    before(:each) { visit user_path(id: @user.id) }

    it 'displays a container for the users' do
      expect(page).to have_css('.container')
    end

    it "displays the user's profile picture" do
      expect(page.has_xpath?("//img[@src = '#{@user.photo}' ]"))
    end

    it 'shows the number of posts the user has written' do
      expect(page).to have_content((@user.posts.count || 0).to_s)
    end

    it "shows the user's bio" do
      expect(page).to have_content('Bio')
      expect(page).to have_content(@user.bio)
    end

    it 'redirects to the post show page on clicking a user post' do
      visit user_posts_path(@user)
      click_link(@post.title) # Make sure @post is defined and represents a post
      expect(page).to have_current_path(user_post_path(@user, @post))
    end
  end
end
