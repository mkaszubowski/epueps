require 'rails_helper'

describe Subject do

  before do
    @subject = Subject.create(
      name: 'subject', 
      description: 'subject description')
  end

  subject { @subject }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :image_name }
  it { should respond_to :lessons }
  it { should respond_to :intro_video_link }
  it { should be_valid }

  describe 'when name is blank' do
    before { @subject.name = ' ' }
    it { should be_valid }

    context 'on publish' do
      it 'should not be valid' do
        expect(@subject.publish).to eq false
      end
    end
  end

  describe 'when description is blank' do
    before { @subject.description = ' ' }
    it { should be_valid }

        context 'on publish' do
      it 'should not be valid' do
        expect(@subject.publish).to eq false
      end
    end

  end

  describe 'when image_name is blank' do
    before { @subject.image_name = ' ' }
    it { should be_valid }
  end


  describe 'to_s method' do
    it "should return subject's name" do
      expect(@subject.to_s).to eq @subject.name
    end
  end

  describe 'when intro_video_link is blank' do
    before { @subject.intro_video_link = ' ' }
    it { should be_valid }
  end

  describe "when intro_video_link hasn't got an id" do
    formats = %w[https://youtube.com youtube.com/test asdasd]
    formats.each do |format|
      before { @subject.intro_video_link = format }
      it { should_not be_valid }
    end
  end

  describe 'when intro_video_link has the right format' do
    formats = %w[youtube.com/watch?v=f43dfaFd 
      https://youtube.com/watch?v=3453f]
    formats.each do |format|
      before { @subject.intro_video_link = format }
      it { should be_valid }
    end
  end

  describe 'when intro_video_link has wrong format' do
    formats = %w[ youtube.com/watch?v=123das 
    youtube.com/watch?v=123&list=PL123 
    https://youtube.com/watch?v=123&index=1&list=1]

    formats.each do |format|
      before do
        @subject.intro_video_link = format
        @subject.save
      end

      it { should be_valid }
    end
  end

  describe 'destroying the subject' do

    it "shouldn't change the subjects count" do
      expect { @subject.destroy }.not_to change(Subject, :count)
    end

    describe 'status' do
      before { @subject.destroy }

      it 'should change to deleted' do
        expect(@subject.status).to eq 'deleted'
        expect(@subject.deleted?).to eq true
      end
    end

    describe 'destroy permament' do
      before do
        @subject.destroy
      end

      it 'should destroy the subject' do
        expect { @subject.destroy }.to change(Subject, :count).by(-1)
      end
    end 
  end

  describe '#status' do

    describe 'default' do
      it 'should be 'draft'' do
        expect(@subject.status).to eq 'draft'
      end
    end

    describe 'publishing' do
      before { @subject.publish }

      it 'should change the status to published' do
        expect(@subject.status).to eq 'published' 
      end
    end
  end

  describe 'scopes' do
    before do
      @published = Subject.create(
        name: 'S1', description: 'S1', status: 'published')
      @draft = Subject.create(
        name: 'S2', description: 'S2', status: 'draft')
      @deleted = Subject.create(
        name: 'S3', description: 's3', status: 'deleted')

      @subject.destroy(true)
    end

    it 'should return the right subjects' do

      expect(Subject.published).to eq [@published]
      expect(Subject.drafts).to eq [@draft]
      expect(Subject.deleted).to eq [@deleted]
      expect(Subject.not_deleted).to eq [@published, @draft]
    end
  end
end
