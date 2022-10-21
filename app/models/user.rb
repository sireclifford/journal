class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
