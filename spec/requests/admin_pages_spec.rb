require 'rails_helper'

RSpec.describe "AdminPages", :type => :request do

  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:moderator) { FactoryGirl.create(:moderator, email: 'foo@baz.com') }

  subject { page }

  describe "site's home page when admin is signed in" do
    before do
      sign_in admin
      visit root_path
    end

    it { should have_link "Panel administracyjny", href: admin_path }
  end

  describe "site's home page when moderator is signed in" do
    before do
      sign_in moderator
      visit root_path
    end

    it 'should have admin panel link' do
      expect(page).to have_link 'Panel administracyjny', href: admin_path
    end
  end

  describe "index page" do
    context "as not-admin user" do
      before { visit admin_path }
      it { should have_content "Nie masz uprawnień do wykonania tej akcji"}
    end

    context "as an admin" do
      before do
        sign_in admin
        visit admin_path
      end

      it { should have_title admin_title("Panel administracyjny") }
      it { should have_content "Panel administracyjny" }
      it { should have_content "Zalogowano jako: #{admin.email}" }

      it { should have_content "Przedmioty: 0" }
      it { should have_content "Lekcje: 0" }
      it { should have_content "Filmy: 0" }
      it { should have_content "Użytkownicy: #{User.count}" }

      it 'should have link to subjects page' do
        expect(page).to have_link 'Przedmioty', href: admin_subjects_path
      end
      it 'should have link to articles page' do
        expect(page).to have_link 'Artykuły', href: admin_articles_path
      end
      it 'should have link to users page' do
        expect(page).to have_link 'Użytkownicy', href: admin_users_path
      end
      it 'should have returning link to the portal' do
        expect(page).to have_link 'Powrót do witryny', href: root_path
      end
    end
  end
end
