class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
