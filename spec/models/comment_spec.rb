require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Test User', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Test Bio', posts_counter: 0) }
  let(:post) { Post.create(title: 'Test Post', author: user, likes_counter: 0, comments_counter: 0) }

  subject { Comment.new(author: user, post: post, text: 'Comment') }

  before { subject.save }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(250) }
  end

  describe 'callbacks' do
    it 'should increment comments_counter after save' do
      expect { subject.save }.to change { post.comments_counter }.by(1)
    end
  end
end
