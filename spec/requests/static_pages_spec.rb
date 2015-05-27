require 'rails_helper'

describe "StaticPages" do

	subject { page }

  describe "Home page" do
    let!(:user)     { FactoryGirl.create(:user) }

  	let!(:subject1) { FactoryGirl.create(:subject, name: 's1', popularity: 3, status: 'published') }
    let!(:subject2) { FactoryGirl.create(:subject, name: 's2', popularity: 5, status: 'published') }
    let!(:deleted_subject) { FactoryGirl.create(:subject, name: 'del', popularity: 7, status: 'deleted') }
    let!(:draft_subject) { FactoryGirl.create(:subject, name: 'draft', popularity: 8, status: 'draft') }

    let!(:article)  { FactoryGirl.create(:article, user_id: user.id ) }

  	before { visit root_path }

  	it { should have_title "Platforma ePUEPS" }
  	it { should have_link "Przeglądaj kursy", href: subjects_path }
  	it { should have_link "Zaloguj się", new_user_session_path }

  	it { should have_selector("h1", text: "Dostępne kursy") }
  	it { should have_link "Wszystkie kursy", href: subjects_path }

    it { should have_content "Najnowsze artykuły" }
    it { should have_content article.title }
    it { should have_content article.body }
    it { should have_link 'Wszystkie artykuły', href: articles_path }
  end
end
