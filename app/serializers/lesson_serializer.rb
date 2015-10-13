class LessonSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color_id, :videos_count

  has_many :videos

  private

  def videos_count
    videos.count
  end
end
