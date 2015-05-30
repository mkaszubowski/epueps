require 'rails_helper'

RSpec.describe ContactEmail, :type => :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:contact_email)).to be_valid
  end

  it 'is invalid without a name' do
    expect(FactoryGirl.build(:contact_email, name: '')).not_to be_valid
  end

  it 'is invalid without an email' do
    expect(FactoryGirl.build(:contact_email, email: '')).not_to be_valid
  end

  it 'is invalid with email with a wrong format' do
    expect(FactoryGirl.build(:contact_email, email: 'in@valid')).not_to be_valid
  end

  it 'is invalid without a message' do
    expect(FactoryGirl.build(:contact_email, message: '')).not_to be_valid
  end
end
