require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = User.create(id: 1, name: 'Test User 1', posts_counter: 0)
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      user = User.create(id: 2, name: 'Test User 2', posts_counter: 0)
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      user = User.create(id: 3, name: 'Test User 3', posts_counter: 0)
      get user_path(user)
      expect(response.body).to include('User Profile')
    end
  end
end
