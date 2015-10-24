class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :link, :watched

  private

  def watched
    object.watched?(current_user)
  end

  def current_profile
    current_user.try(:profile)
  end
end
