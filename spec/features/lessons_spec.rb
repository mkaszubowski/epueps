require 'rails_helper'

describe 'Lessons' do
	subject { page }

	let(:admin) { FactoryGirl.create(:admin) }
	let!(:subject1) { FactoryGirl.create(:subject) }
	let!(:lesson) { FactoryGirl.create(:lesson, subject_id: subject1.id) }
	let!(:video) { FactoryGirl.create(:video, lesson_id: lesson.id) }

	before do
		sign_in admin
	end

	describe 'new' do
		
		before { visit new_admin_subject_lesson_path(subject1) }
		
		it { should have_title admin_title('Nowa lekcja') }
		it { should have_content 'Nowa lekcja' }
		it { should have_content subject1.name }
		it { should have_selector 'form' }


		describe 'it should create a new lesson' do
			before do
				@lesson = subject1.lessons.create(name: 'lesson', 
					description: 'lorem')
				fill_in 'Nazwa', with: @lesson.name
				fill_in 'Opis', with: @lesson.description

				click_button 'Dodaj lekcję'
			end

			it { should have_content 'Dodano lekcję' }
			it { should have_content @lesson }
		end

		describe 'for blank data' do
			before { click_button 'Dodaj lekcję' }

			it { should have_content 'Wystąpił błąd' }
		end

	end

	describe 'show' do
		before { visit admin_subject_lesson_path(subject1, lesson) }

		it { should have_title admin_title(lesson) }
		it { should have_content lesson }
		it { should have_content subject1 } 


		it { should have_link 'Usuń', 
					href: admin_subject_lesson_path(subject1, lesson) }
		it { should have_link 'Edytuj', 
					href: edit_admin_subject_lesson_path(subject1, lesson) }
		it { should have_link 'Dodaj film', 
					href: new_admin_subject_lesson_video_path(subject1, lesson) }


		it { should have_content 'Filmy' }

		it { should have_content video.name }

	end

	describe 'edit' do
		before { visit edit_admin_subject_lesson_path(subject1, lesson) }

		it { should have_title admin_title("Edycja - #{lesson}") }
		it { should have_content "Edycja - #{lesson}" }
		it { should have_content subject1.name }

		it { should have_button 'Zapisz zmiany' }

		describe 'saving changes' do
			context 'with invalid data' do
				before do 
					fill_in 'Nazwa',		with: ''
					fill_in 'Opis',			with: ''

					click_button 'Zapisz zmiany'
				end

				it { should have_content 'Wystąpiły błędy' }
			end

			context 'with valida data' do
				before do
					fill_in 'Nazwa', 		with: 'New lesson'
					fill_in 'Opis',			with: 'Description'

					click_button 'Zapisz zmiany'
				end

				it { should have_content 'Zaktualizowano lekcję' }
				it { should have_content 'New lesson' }
			end
		end
	end

end
