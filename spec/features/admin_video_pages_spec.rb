require 'rails_helper'

RSpec.describe 'AdminVideoPages', :type => :request do

  let(:admin) { FactoryGirl.create(:admin) }
  let!(:subject1) { FactoryGirl.create(:subject) }
  let!(:lesson) { FactoryGirl.create(:lesson,
                                     subject_id: subject1.id) }

  let!(:video) { FactoryGirl.create(:video, lesson_id: lesson.id) }

  subject { page }

  before do
    sign_in admin
  end

  describe 'new video page' do
    before do
      visit new_admin_subject_lesson_video_path(subject1, lesson)
    end

    it { should have_title admin_title('Dodaj film') }
    it { should have_content 'Dodaj film' }
    it { should have_content subject1 }
    it { should have_content lesson }
    it { should have_button 'Dodaj film' }


    describe 'submitting the form' do

      context 'with invalid data' do
        before do
          # delete example video
          lesson.videos.first.destroy
          fill_in 'Nazwa',      with: 'fff'
          fill_in 'Link',       with: 'invalid'
        end

        it 'should not change the video count' do
          expect { click_button 'Dodaj film' }.
            not_to change(Video, :count)
        end

        describe 'flash message' do
          before { click_button 'Dodaj film' }

          it { should have_content 'Wystąpił błąd' }
        end
      end

      context 'with valid data' do
        before do
          #delete example video
          lesson.videos.first.destroy
          fill_in 'Nazwa',  with: 'Video1'
          fill_in 'Link',   with: 'youtube.com/watch?v=123'
        end

        it 'should change the video count' do
          expect { click_button 'Dodaj film' }.
            to change(Video, :count).by(1)
        end

        describe 'flash message' do
          before { click_button 'Dodaj film' }

          it { should have_content 'Dodano film' }
          it { should have_content 'Video1' }
        end
      end
    end
  end

  describe 'deleting video' do
    before do
      visit admin_subject_lesson_path(subject1, lesson)
    end

    it 'should change the video count' do

      expect {click_link 'Usuń',
        href: admin_subject_lesson_video_path(subject1, lesson, video) }.
        to change(Video, :count).by(-1)
    end
  end


  describe 'edit page' do
    before do
      visit edit_admin_subject_lesson_video_path(subject1,
        lesson, video)
    end

    it { should have_content 'Edytuj film' }
    it { should have_content 'Edytuj film' }
    it { should have_button 'Zapisz zmiany' }

    describe 'submitting changes' do
      context 'with invalid data' do
        before do
          fill_in 'Nazwa',  with: ''
          fill_in 'Link',   with: 'invalid'
          click_button 'Zapisz zmiany'
        end

        it { should have_content 'Wystąpił błąd' }
      end

      context 'with valid data' do
        before do
          fill_in 'Nazwa',  with: 'Updated video'
          fill_in 'Link',   with: 'youtube.com/watch?v=123'
          click_button 'Zapisz zmiany'
        end

        it { should have_content 'Zaktualizowano film' }
        it { should have_content 'Updated video' }
      end
    end
  end
end
