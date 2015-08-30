class LessonSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color_id

  has_many :videos
end
