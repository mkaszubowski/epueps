class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :link, :watched

  private

  def watched
    return false unless current_profile

    current_profile.watched_videos.include? object
  end

  def current_profile
    current_user.try(:profile)
  end
end
