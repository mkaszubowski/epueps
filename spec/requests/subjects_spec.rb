require 'rails_helper'

RSpec.describe 'Subjects', :type => :request do
  subject { page }

  let!(:user) { FactoryGirl.create(:user) }

  let!(:subject1) { FactoryGirl.create(:subject,
    name: 'S1',
    popularity: 3,
    created_at: 1.hour.ago,
    intro_video_link: 'youtube.com/watch?v=test',
    status: 'published') }
  let!(:subject2) { FactoryGirl.create(:subject,
    name: 'S2',
    popularity: 5,
    created_at: 2.hour.ago,
    intro_video_link: 'https://youtube.com/watch?v=test',
    status: 'published') }


  describe 'index page' do
    before do
      pending('implement js test for react')
      fail
    end
    before { visit subjects_path }

    it { should have_title normal_title('Wszystkie kursy') }
    it { should_not have_content 'Witamy' }
    it { should_not have_link 'Przeglądaj kursy' }
    it { should have_selector('h1', text: 'Wszystkie kursy') }
    it { should have_link 'Popularne' }
    it { should have_link 'Najnowsze' }

    it { should have_content 'S1' }
    it { should have_content 'S2' }
    it { should have_content subject1.description }

    describe 'subjects ordered by most popular' do
      before { click_link 'Popularne' }

      it { should have_content /S2.*S1/ }

      describe 'after page reload' do
        before { visit subjects_path }

        it { should have_content /S2.*S1/ }
      end
    end
    describe 'subjects ordered by most recent' do
      before { click_link 'Najnowsze' }

      it { should have_content /S1.*S2/ }
    end

    describe 'with default order' do
      it { should have_content /S1.*S2/ }
    end

  end

  describe 'info page' do
    let!(:lesson1) do
      FactoryGirl.create(
        :lesson,
        subject_id: subject1.id)
    end
    let!(:video) { FactoryGirl.create(:video, lesson_id: lesson1.id) }

    before { visit subject_info_path(subject1) }

    it { should have_title normal_title("#{subject1.name} - informacje") }
    it { should have_content subject1.name}
    it { should have_content subject1.description }
    it { should have_content 'Dostępne lekcje' }
    it { should have_link 'Zacznij kurs' }

    it { should have_css 'iframe' }


    it { should have_link lesson1.name }

    describe 'lesson link' do
      before { click_link lesson1.name }

      it 'should redirect to subject#show' do
        expect(page).to have_css('h1', text: subject1.name)
      end
    end
  end

  describe 'show page' do


    describe "when subject hasn't got any lessons" do
      before { visit subject_path(subject1) }
      it { should have_content 'nie ma żadnych lekcji' }
    end

    describe 'when subject has at least one lesson' do
      before do
        @lesson = subject1.lessons.create(
          name: 'Lesson1',
          description: 'Lorem ipsum1')

        @video1 = @lesson.videos.create(name: 'video 1',
          link: 'youtube.com/watch?v=asdf')
        @video2 = @lesson.videos.create(name: 'video 2',
          link: 'youtube.com/watch?v=asdff')

        @lesson2 = subject1.lessons.create(
          name: 'Lesson2',
          description: 'Lorem ipsum2')

        @video3 = @lesson2.videos.create(name: 'video 3',
          link: 'youtube.com/watch?v=asdff')
        @video4 = @lesson2.videos.create(name: 'video 4',
          link: 'youtube.com/watch?v=asdff')

        visit subject_path(subject1)
      end

      it { should have_content subject1.name }
      it { should have_title normal_title("#{subject1.name}") }
      it { should have_link @lesson.name }

      it { should have_link 'video 1' }
      it { should have_link 'video 2' }

      # Subject menu
      it { should have_link @lesson.name }
      it { should have_link @lesson2.name }


      describe 'after clicking menu links' do
        before { click_link @video4.name }
        it { should have_css("iframe[id='video-#{@video4.id}']") }
        it { should have_content @video4.lesson.description }
        it { should have_content @video4.lesson.subject.description }

        describe 'after leaving page' do
          before do
            visit root_path
            visit subject_path(subject1)
          end

          it 'should rememeber last video' do
            expect(page).to have_css("iframe[id='video-#{@video4.id}']")
          end
        end
      end

      describe 'video for signed in only' do
        before do
          @video_signed_in = @lesson.videos.create!(
            name: 'signed_in',
            link: 'youtube.com/watch?v=123',
            signed_in_only: true)
        end

        context 'when user is not signed in' do
          before do
            visit subject_path(subject1)
            click_link @video_signed_in
          end

          it { should have_content 'Tylko dla zalogowanych' }
          it { should have_content '(tylko dla zalogowanych)' }
          it { should have_link 'Zaloguj się' }
          it { should have_link 'Zarejestruj się' }
        end

        context 'when user is signed in' do
          before do
            sign_in user
            visit subject_path(subject1)
            click_link @video_signed_in
          end

          it { should_not have_content 'Tylko dla zalogowanych' }
          it { should_not have_content '(tylko dla zalogowanych)' }
          it { should_not have_link 'Zaloguj się' }
        end

      end
    end
  end

end
