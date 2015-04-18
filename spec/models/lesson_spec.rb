require 'rails_helper'

describe Lesson do
  before do
  	@subject = Subject.create(
      name: "subject", 
      description: "subject description")
  	@lesson = @subject.lessons.create(
      name: "lesson", 
      description: "lesson description",
      position: 1)
    @video = @lesson.videos.create(
      link: "https://www.youtube.com/watch?v=5ca8p5OWniI",
      name: "Wykład")
  end

  subject { @lesson }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :subject_id }
  it { should respond_to :videos }	

  it { should be_valid }
  
  describe "when subject_id is not present" do
  	before { @lesson.subject_id = nil }
  	it { should_not be_valid }
  end

  describe "when name is blank" do
  	before { @lesson.name = " " }
  	it { should_not be_valid }
  end

  describe "when description is blank" do
  	before { @lesson.description = " " }
  	it { should_not be_valid }
  end

  it 'sets the position automatically if it is empty' do
    @lesson.position = ''
    expect(@lesson).to be_valid
    expect(@lesson.position).not_to be_nil
  end

  describe "default scope" do
    before do
      @lesson2 = Lesson.create!(
        name: "lesson2",
        description: "desc",
        subject_id: @subject.id)
    end

    it "should be ordered by created_at ASC" do
      expect(Lesson.all).to eq [@lesson, @lesson2]
    end
  end

  describe "deleting lesson" do
    before { @lesson.destroy! }

    it "should delete its videos" do
      expect(Video.where(id: @video.id)).to be_empty
    end
  end

  describe "lesson thumbnail" do 
    it "should have the right src" do
      expect(@lesson.thumbnail).to eq @lesson.videos.first.thumbnail
    end
  end


  describe '#to_s' do
    it "should return lesson's name" do
      expect(@lesson.to_s). to eq @lesson.name
    end
  end

  describe '#resources' do
    before do
      @lesson_test = @subject.lessons.create(name: "l2", description: "desc")
      # delete the example video
      @video_test = @lesson_test.videos.create(
        name: "v2", 
        link: "youtube.com/watch?v=123") 
    end

    it "should return all the resources" do
      expect(@lesson_test.resources).to eq [@video_test]
    end
  end

  describe '#color_class' do
    before do 
      @lesson = @subject.lessons.create(name: "lesson", description: "desc")
    end

    it 'is empty when lesson has no custom color' do
      expect(@lesson.color_class).to eq ''
    end

    it 'returns correct color class' do
      @lesson.update_attribute(:color_id, 1)
      expect(@lesson.color_class).to eq 'color-1'
    end
  end

  describe "new lesson" do
    before do
      @new_lesson = Lesson.new(name: "new", description: "desc", 
        subject_id: 1)
      @new_lesson.save

    end

    describe "after adding first new video" do
      before do
        @video1 = @new_lesson.videos.create(name: "video", 
          link: "youtube.com/watch?v=test")       
      end

    end
  end
end
