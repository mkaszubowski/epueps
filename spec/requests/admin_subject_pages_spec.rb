require 'rails_helper'

RSpec.describe 'AdminSubjectPages', :type => :request do

  let(:admin) { FactoryGirl.create(:admin) }
  let!(:subject1) { FactoryGirl.create(:subject, name: 'S1') }
  let!(:subject2) { FactoryGirl.create(:subject, name: 'S2') }
  let!(:deleted_subject) { FactoryGirl.create(:subject, name: 'S3', status: 'deleted') }
  let!(:lesson1) { FactoryGirl.create(:lesson, subject: subject1) }

  subject { page }

  describe 'index page' do
    context 'with no privileges' do
      before { visit admin_subjects_path }

      it { should have_content 'Nie masz uprawnień' }
    end

    context 'as an admin' do
      before do
        sign_in admin
        visit admin_subjects_path 
      end

      it { should have_title admin_title('Wszystkie przedmioty') }
      it { should have_content 'Wszystkie przedmioty' }

      it { should have_content 'S1' } 
      it { should have_content 'S2' }

      it { should have_link 'Usuń', 
            href: admin_subject_path(subject2) }
      it { should have_link 'Edytuj',
            href: edit_admin_subject_path(subject2) }

      it { should have_content subject1.lessons.count }
      it { should have_content subject2.lessons.count }

      it { should have_link 'Nowy przedmiot' }


      describe 'deleting subject' do
        
        describe 'flash message' do
          before { click_link 'Usuń', 
                   href: admin_subject_path(subject1)}
          it { should have_content 'Usunięto przedmiot' }
        end

        it 'should not change the subject count' do
          expect { click_link 'Usuń', 
                   href: admin_subject_path(subject1) }.
            not_to change(Subject, :count)
        end

        it 'should change subject status' do
          click_link 'Usuń', href: admin_subject_path(subject1) 
          subject1.reload
          
          expect(subject1.status).to eq 'deleted'
        end
      end

      describe 'sorting the table' do

          describe 'by lessons count' do
            before { click_link 'Liczba lekcji' }

            it { should have_content /S2.*S1/ }

            describe 'and then in the other direction' do
              before { click_link 'Liczba lekcji' }

              it { should have_content /S1.*S2/ }
            end
          end
      end

      describe "publishing the subject" do
        before { first(:link, "Opublikuj").click }

        it { should have_content "Opublikowano przedmiot" }
        it { should have_content "Opublikowany" }
      end
    end
  end

  describe 'new subject page' do
    before do
      sign_in admin
      visit new_admin_subject_path
    end

    it { should have_title admin_title('Nowy przedmiot') }
    it { should have_content 'Nowy przedmiot' }

    it { should have_button 'Dodaj przedmiot' } 

    describe 'creating new subject' do
      before do
        fill_in 'Nazwa',      with: 'Przedmiot'
        fill_in 'Opis',       with: 'Opis'
        fill_in 'Trailer',    with: 'youtube.com/watch?v=123'
      end

      it 'should change the subject count' do
        expect { click_button 'Dodaj przedmiot' }.
          to change(Subject, :count).by(1)
      end

      describe 'flash message' do
        before { click_button 'Dodaj przedmiot' }

        it { should have_content 'Dodano przedmiot' }
      end
    end
  end

  describe 'edit subject page' do
    before do 
      sign_in admin
      visit edit_admin_subject_path(subject1)
    end

    it { should have_title admin_title("Edycja - #{subject1.name}") }
    it { should have_content "Edycja - #{subject1.name}" }
    it { should have_button 'Zapisz zmiany' }

    describe 'saving changes' do
      context 'with invalid data' do
        before do
          fill_in 'Nazwa',      with: ''
          fill_in 'Opis',       with: ''
          fill_in 'Trailer',    with: ''
          click_button 'Zapisz zmiany'
        end

        it { should have_content 'Wystąpił błąd' }
      end

      context 'with valid data' do
        before do
          fill_in 'Nazwa',      with: 'Subject3'
          fill_in 'Opis',       with: 'Desc3'
          fill_in 'Trailer',    with: 'youtube.com/watch?v=123'
          click_button 'Zapisz zmiany'
        end

        it { should have_content 'Zaktualizowano przedmiot' }

        # redirect to subject index page
        it { should have_content 'Wszystkie przedmioty' }
        it { should have_content 'Subject3' }
      end
    end
  end

  describe 'show subject page' do
    before do
      sign_in admin
      visit admin_subject_path(subject1)
    end

    it { should have_title admin_title("#{subject1.name}") }
    it { should have_content "#{subject1.name}" }

    it { should have_link 'Nowa lekcja' }
    it { should have_link 'Usuń' }
    it { should have_link 'Edytuj' }
    
    it { should have_content 'Lekcje' }

    it { should have_content lesson1.name }

  end

  describe 'deleted subjects page' do
    before do
      sign_in admin
      visit deleted_admin_subjects_path 
    end

    it 'should show only deleted subjects' do
      expect(page).to have_content deleted_subject.name
      expect(page).not_to have_content subject1.name
      expect(page).not_to have_content subject2.name
    end

    describe 'deleting subject' do
      it 'should delete subject' do
        expect { click_link 'Usuń' }.to change(Subject, :count).by(-1)
      end

      it 'should remove subject from deleted subjects list' do
        click_link 'Usuń'
        expect(page).not_to have_content deleted_subject.name
      end
    end
  end
end
