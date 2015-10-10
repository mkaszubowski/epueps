require 'rails_helper'

describe 'Static Pages', type: :feature do

  describe 'Home page' do
    let!(:user)     { FactoryGirl.create(:user) }

    let(:now) { DateTime.now }
    let!(:article1) do
      FactoryGirl.create(:article, user_id: user.id, created_at: now)
    end

    let!(:article2) do
      FactoryGirl.create(:article, body: 'article2', user_id: user.id, created_at: now - 1)
    end

    before { visit root_path }

    it 'should have sign in link' do
      expect(page).to have_xpath("//a[@href='/users/sign_in']")
    end

    describe 'articles section' do
      it 'should display first article\'s title and body' do
        expect(page).to have_content Article.first.title
        expect(page).to have_content Article.first.body
      end

      it 'should display only title for other articles' do
        expect(page).to have_content article2.title
        expect(page).not_to have_content article2.body
      end

      it 'should display link to all articles' do
        expect(page).to have_link 'Wszystkie artykuły', href: articles_path
      end
    end
  end
end
