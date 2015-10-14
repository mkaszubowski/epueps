require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'has a valid factory' do
    expect(build(:profile)).to be_valid
  end

  it 'is invalid without user_id' do
    expect(build(:profile, user_id: nil)).not_to be_valid
  end

  describe 'watched videos' do
    let!(:profile) { create(:profile) }
    let!(:watched_video) { create(:video) }
    let!(:video) { create(:video) }

    before do
      create(:profile_video, profile: profile, video: watched_video)
    end

    it 'displays user\'s watched videos' do
      expect(profile.watched_videos).to include watched_video
    end

    it 'does not display not watched videos' do
      expect(profile.watched_videos).not_to include video
    end
  end
end
