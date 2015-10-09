require 'rails_helper'

RSpec.describe Article, :type => :model do

  let!(:user) { FactoryGirl.create(:user) }

  before do
    @article = user.articles.create(title: "Title", body: "Body")
  end

  subject { @article }

  describe "when title is blank" do
    before { @article.title = " " }

    it { should_not be_valid }
  end

  describe "when body is blank" do
    before { @article.body = " " }

    it { should_not be_valid }
  end

  describe "when user id is blank" do
    before { @article.user_id = nil }

    it { should_not be_valid }
  end

  describe '#short_title' do

    describe 'when title is too long' do
      before { @article.title = 'a '*70 }

      it "should show only first 50 characters" do
        expect(@article.short_title.length).to be <= 50
      end
    end

    describe 'when title is not too long' do
      before { @article.title = 'short title' }

      it 'should show unchanged title' do
        expect(@article.short_title).to eq 'short title'
      end
    end
  end

  describe '#published_at' do
    it 'should return date in a correct format' do
      expect(@article.published_at).to match /\d{2}\.\d{2}\.\d{4}/
    end
  end

  describe '#author' do
    it 'should return article author\'s email' do
      expect(@article.author).to eq @article.user.email
    end
  end

  describe '#newest' do
    before do
      Article.destroy_all
      @article_old = FactoryGirl.create(
        :article, title: 'old', created_at: DateTime.now() - 1)
      @article_new = FactoryGirl.create(
        :article, title: 'new', created_at: DateTime.now())
    end

    it 'returns articles sorted by created_at' do
      expect(Article.newest.to_a).to eq [@article_new, @article_old]
    end
  end
end

