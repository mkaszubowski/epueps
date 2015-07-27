require 'rails_helper'

RSpec.describe 'Lesson requests', type: :request do
  describe 'GET /subject/:id/lessons' do
    let!(:subject1) { FactoryGirl.create(:subject) }

    let!(:lesson1) { FactoryGirl.create(:lesson, subject: subject1) }
    let!(:lesson2) { FactoryGirl.create(:lesson, subject: subject1) }

    let!(:video1)   { FactoryGirl.create(:video, lesson: lesson1) }
    let!(:video2)   { FactoryGirl.create(:video, lesson: lesson2) }

    before { get subject_lessons_path(subject1), format: :json }

    it 'returns status code 200' do
      expect(response).to be_success
    end

    it 'returns the list of all lessons' do
      lesson_ids = JSON.parse(response.body).map { |lesson| lesson['id'] }

      expect(lesson_ids).to include lesson1.id
      expect(lesson_ids).to include lesson2.id
    end

    it 'returns videos for each lesson' do
      lessons = JSON.parse(response.body)
      video_ids = lessons.map { |lesson| lesson['videos'] }.flatten
                         .map { |video|  video['id'] }.flatten

      expect(video_ids).to include video1.id
      expect(video_ids).to include video2.id
    end
  end
end
