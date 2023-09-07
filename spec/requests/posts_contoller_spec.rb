require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user_id) { 1 }
  let(:post_id) { 1 }
  let(:user_posts_url) { "/users/#{user_id}/posts" }
  let(:user_post_url) { "#{user_posts_url}/#{post_id}" }

  describe 'GET #index' do
    before do
      get user_posts_url
    end

    it 'renders the posts/index template' do
      expect(response).to render_template('posts/index')
    end

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET #show' do
    before do
      get user_post_url
    end

    it 'renders the posts/show template' do
      expect(response).to render_template('posts/show')
    end

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it 'includes the correct placeholder text in the response body' do
      expect(response.body).to include('Here is a single posts for a given user')
    end
  end
end