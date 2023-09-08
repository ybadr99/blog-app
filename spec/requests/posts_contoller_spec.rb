require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before :each do
    @user = User.create(
      name: 'yousef',
      photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80',
      bio: 'I am a user1',
      posts_counter: 5
    )
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index, params: { user_id: @user.id }
      expect(response).to render_template('index')
    end

    # Add more tests for index action as needed
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { user_id: @user.id }
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'creates a new post' do
      expect do
        post :create, params: { user_id: @user.id, title: 'Test Title', text: 'Test Text' }
      end.to change(Post, :count).by(1)
    end

    it "redirects to the user's posts page on successful creation" do
      post :create, params: { user_id: @user.id, title: 'Test Title', text: 'Test Text' }
      expect(response).to redirect_to(user_posts_path(@user))
    end

    it "renders the 'new' template on failed creation" do
      # Simulate a failed post creation by not providing required params
      post :create, params: { user_id: @user.id, title: '', text: '' }
      expect(response).to render_template('new')
    end
  end
end
