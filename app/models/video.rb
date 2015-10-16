class Video < ActiveRecord::Base
  include YoutubeUtilities

  before_save :validate!

  belongs_to :lesson, counter_cache: true

  default_scope { order('created_at ASC') }

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

  protected

  def validate!
    self.link = validate_youtube_link(self.link)
  end

  def video_id
    self.link.gsub(/^.*v=/, "")
  end

end
