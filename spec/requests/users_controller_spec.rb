require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(200)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('Here is a list users')
    end
  end

  describe 'GET /users/:id' do
    it 'returns http success' do
      user = User.create(name: 'Yousef', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      user = User.create(name: 'Yousef', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      user = User.create(name: 'Yousef', posts_counter: 0)
      get "/users/#{user.id}"
      expect(response.body).to include('Here is a user')
    end
  end
end