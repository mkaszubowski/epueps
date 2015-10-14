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
end
