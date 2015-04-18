class Lesson < ActiveRecord::Base

  # has_many  :lesson_resources
  has_many  :videos, 
            dependent: :destroy

  belongs_to :subject, counter_cache: true

  default_scope { order('created_at ASC') }

  validates :subject_id,  presence: true
  validates :name,        presence:  
                          { message: "Nazwa nie może być pusta" }
  validates :description, presence: 
                          { message: "Opis nie może być pusty" }
                      
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
end
