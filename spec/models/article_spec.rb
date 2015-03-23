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

  describe "markdown renderer" do
    before { @article.body = '# Header' }

    it "shoud render correct html" do
      expect(@article.body_text).to eq "<h1>Header</h1>\n"
    end
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
end

