class Video < ActiveRecord::Base
  include YoutubeUtilities

  acts_as_list scope: :lesson

  before_save :validate!
  before_validation :set_initial_position

  belongs_to :lesson, counter_cache: true

  default_scope { order('position ASC') }

  validates :link,
            presence: { message: 'Link do filmu nie może być pusty' },
            format:
            { with: VIDEO_LINK_REGEX,
              message: 'Niepoprawny format'
            }
  validates :name,
            presence: { message: "Nazwa filmu nie może być pusta" }
  validates :lesson_id, presence: true

  def embed_link
    link.gsub("watch?v=", "embed/") + video_params
  end

  def thumbnail
    "https://img.youtube.com/vi/#{video_id}/1.jpg"
  end

  def to_s
    name
  end

  def signed_in_only?
    signed_in_only
  end

  def watched?(user)
    return false unless user

    user.profile.watched_videos.include? self
  end

  protected

  def validate!
    self.link = validate_youtube_link(self.link)
  end

  def video_id
    self.link.gsub(/^.*v=/, "")
  end

  def set_initial_position
    if position.nil?
      max_position = subject.lessons.map(&:position).compact.max.to_i
      self.position = max_position + 1
    end
  end
end
