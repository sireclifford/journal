require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'User') }
  let(:post) { Post.create(title: 'Post', author: user) }
  let(:comment) { Comment.create(text: 'Comment', author: user, post: post) }
  let(:like) { Like.create(author: user, post: post) }
  let(:posts) { user.posts }

  describe 'associations' do
    it { should have_many(:comments).with_foreign_key('author_id') }
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:likes).with_foreign_key('author_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3).is_at_most(100) }
  end

  describe 'recent_posts' do
    it 'returns the 3 most recent posts' do
      expect(user.recent_posts).to eq(posts)
    end
  end
end
