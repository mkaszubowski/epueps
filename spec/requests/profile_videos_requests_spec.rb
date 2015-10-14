require 'rails_helper'

RSpec.describe 'Profile videos', type: :request do
  describe 'POST /profile_videos' do
    let!(:video) { create(:video) }

    describe 'for signed in users' do
      let(:profile) { @user.profile }

      before  do
        @user = create(:user)
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(@user)

        post profile_videos_path, format: :json, video_id: video.id
      end

      it 'returns status code 200' do
        expect(response).to be_success
      end

      it 'adds video to profile\'s watched videos' do
        expect(profile.watched_videos).to include video
      end
    end

    describe 'for not signed in users' do
      before do
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(nil)

        post profile_videos_path, format: :json, video_id: video.id
      end

      it 'returns status code 422' do
        expect(response.status).to eq 422
      end
    end
  end
end
