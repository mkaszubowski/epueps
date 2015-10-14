class ProfileVideosController < ApplicationController
  respond_to :json

  def create
    if current_user
      profile_video =
        current_profile.profile_videos.create(video_id: params[:video_id])

      render json: profile_video
    else
      render json: nil, status: :unprocessable_entity
    end
  end

  protected

  def current_profile
    current_user.profile
  end
end
