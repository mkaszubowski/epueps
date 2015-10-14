require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'has a valid factory' do
    expect(build(:profile)).to be_valid
  end

  it 'is invalid without user_id' do
    expect(build(:profile, user_id: nil)).not_to be_valid
  end
end
