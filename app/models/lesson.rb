class Lesson < ActiveRecord::Base

  # has_many  :lesson_resources
  has_many  :videos, dependent: :destroy

  belongs_to :subject, counter_cache: true

  default_scope { order('position ASC') }

  before_validation :set_initial_position

  validates :subject_id, presence: true
  validates :name, presence: 
    { message: "Nazwa nie może być pusta" }
  validates :description, presence: 
    { message: "Opis nie może być pusty" }
  validates :position, presence: 
    { message: "Pozycja nie może być pusta" }

  # TODO: Add other resources
  def resources
    videos
  end

  def thumbnail
    videos.first.thumbnail
  end

  def to_s
    name
  end  

  def color_class
    return '' if color_id.nil?
    "color-#{color_id}" 
  end

  protected

  def set_initial_position
    if position.nil?
      max_position = subject.lessons.map(&:position).compact.max.to_i
      self.position = max_position + 1 
    end
  end
end
