require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = User.new(email: 'foo@bar.com', password: 'foobar123')
    @user.save
  end

  subject { @user }

  describe 'when email is blank' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'when password is blank' do
    before { @user.password = ' ' }
    it { should_not be_valid }
  end

  describe 'when username is blank' do
    context 'on create' do
      before do
        @user = User.new(email: 'foo@bar2.com', password: 'foobar123', username: '')
      end

      it 'should be valid' do
        expect(@user).to be_valid
      end

      it 'should generate username from email' do
        @user.save
        expect(@user.username).to eq 'foo'
      end
    end

    context 'on update' do
      it 'is not valid' do
        @user.username = ''
        expect(@user.save).to eq false
      end
    end
  end

  describe 'role' do
    context 'for admin users' do
      before { @user.role = 'admin' }

      describe '#admin?' do
        it 'should be true' do
          expect(@user.admin?).to eq true
        end
      end

      describe '#moderator?' do
        it 'should be false' do
          expect(@user.moderator?).to eq false
        end
      end
    end

    context 'for normal users' do
      describe 'admin?' do
        it 'should be false' do
          expect(@user.admin?).to eq false
        end
      end

      describe '#moderator?' do
        it 'should be false' do
          expect(@user.moderator?).to eq false
        end
      end
    end

    context 'for moderators' do
      before { @user.role = 'moderator' }

      describe 'admin?' do
        it 'should be false' do
          expect(@user.admin?).to eq false
        end
      end

      describe '#moderator?' do
        it 'should be false' do
          expect(@user.moderator?).to eq true
        end
      end
    end
  end

  describe '#to_s' do
    it 'should display user\'s email' do
      expect(@user.to_s).to eq @user.email
    end
  end

  describe 'when email is already in database' do
    before do
      @user2 = User.new(email: 'foo@bar.com', password: 'foobar123')
      @user2.save
    end

    subject { @user2 }
    it { should_not be_valid }
  end

  describe 'profile' do
    it 'is automatically generated for new users' do
      expect { FactoryGirl.create(:user) }.to change(Profile, :count).by(1)
    end

    it 'is destroyed after destroying the user' do
      user = FactoryGirl.create(:user)

      expect { user.destroy }.to change(Profile, :count).by(-1)
    end
  end
end
