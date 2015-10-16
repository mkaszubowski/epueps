require 'rails_helper'

RSpec.describe ProfileVideo, :type => :model do
  it 'has a valid factory' do
    expect(build(:profile_video)).to be_valid
  end

  it 'is invalid without profile id' do
    expect(build(:profile_video, profile_id: nil)).not_to be_valid
  end

  it 'is invalid without video id' do
    expect(build(:profile_video, video_id: nil)).not_to be_valid
  end

  describe 'without unique video id' do
    context 'with the same profile ids' do
      it 'is invalid' do
        profile_video = create(:profile_video)

        expect(
          build(
            :profile_video,
            profile: profile_video.profile,
            video_id: profile_video.video_id)
        ).not_to be_valid
      end
    end

    context 'with different profile ids' do
      it 'is valid' do
        profile_video = create(:profile_video)

        expect(
          build(
            :profile_video,
            video_id: profile_video.video_id)
        ).to be_valid
      end
    end
  end
end
