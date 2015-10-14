require 'rails_helper'

RSpec.describe Video, :type => :model do
  let!(:subject1) { FactoryGirl.create(:subject) }
  let!(:lesson) { FactoryGirl.create(:lesson, subject_id: subject1.id) }
  before do
    @video = lesson.videos.create(
      name: "Video",
      link: "https://www.youtube.com/watch?v=5ca8p5OWniI")
    @video.save
  end

  subject { @video }

  it 'has a valid factory' do
    expect(build(:video)).to be_valid
  end

  it { should respond_to :name }
  it { should respond_to :link }
  it { should respond_to :lesson_id }

  it { should be_valid }

  describe "when name is blank" do
    before { @video.name = " " }
    it { should_not be_valid }
  end

  describe "when link is blank" do
    before { @video.link = " " }
    it { should_not be_valid }
  end

  describe "when lesson id is blank" do
    before { @video.lesson_id = nil }
    it { should_not be_valid }
  end

  describe "when link has wrong format" do
    formats = %w[ youtube.com/watch?v=123das
                  youtube.com/watch?v=123&list=PL123
                  https://youtube.com/watch?v=123&index=1&list=1]

    formats.each do |format|
      before do
        @video.link = format
        @video.save
      end

      it { should be_valid }
    end
  end

  describe "when link hasn't got an id" do
    formats = %w[https://youtube.com youtube.com/test]
    formats.each do |format|
      before { @video.link = format }
      it { should_not be_valid }
    end
  end

  describe "when link has the right format" do
    formats = %w[youtube.com/watch?v=f43dfaFd https://youtube.com/watch?v=3453f]
    formats.each do |format|
      before { @video.link = format }
      it { should be_valid }
    end
  end

  describe "thumbnail" do
    it "should have the right format" do
      expect(@video.thumbnail).to eq "https://img.youtube.com/vi/5ca8p5OWniI/1.jpg"
    end
  end

  describe "default scope" do
    before do
     @video2 = Video.create!(
       name: "abc",
       link: "youtube.com/watch?v=123",
       signed_in_only: false,
       lesson_id: lesson.id)
    end

    it "should be ordered by created_at ASC" do
      expect(Video.all).to eq [@video, @video2]
    end
  end
end
