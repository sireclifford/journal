require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Test User', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Test Bio') }
  let(:post) { Post.create(title: 'Test Post', author: user, likes_counter: 0, comments_counter: 0) }

  subject { Like.new(author: user, post: post) }

  before { subject.save }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe 'callbacks' do
    it 'should increment likes_counter after save' do
      expect { subject.save }.to change { post.likes_counter }.by(1)
    end
  end
end
