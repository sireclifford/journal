require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Test User', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Test Bio') }
  let(:comment) { Comment.create(text: 'Test Comment', author: user, post: post) }
  let(:like) { Like.create(author: user, post: post) }

  subject { Post.new(author: user, title: 'Post', likes_counter: 5, comments_counter: 5) }

  before { subject.save }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_numericality_of(:likes_counter).is_greater_than_or_equal_to(0).only_integer }
  end

  describe 'callbacks' do
    it 'should increment posts_counter after save' do
      expect { subject.save }.to change { user.posts_counter }.by(1)
    end
  end

  describe 'methods' do
    before { 5.times { |comment| Comment.create(author: user, text: comment, post: subject) } }
    it 'should return recent comments' do
      expect(subject.recent_comments).to eq(subject.comments.last(5).reverse)
    end
  end
end
