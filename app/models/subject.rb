class Subject < ActiveRecord::Base
  extend FriendlyId
  include YoutubeUtilities

  before_save :validate_link

  has_many :lessons, dependent: :destroy

  friendly_id :name, use: [:slugged, :finders]

  mount_uploader :image, SubjectImageUploader

  scope :popular,     -> { order('popularity DESC') }
  scope :recent,      -> { order('created_at DESC') }
  scope :deleted,     -> { where(status: 'deleted') }
  scope :published,   -> { where(status: 'published') }
  scope :drafts,      -> { where(status: 'draft') }
  scope :not_deleted, -> { where("status != 'deleted'") }

  validates :name,
            presence: { message: 'Nazwa nie może być pusta' }
  validates :description,
            presence: { message: 'Opis nie może być pusty' },
            on: :publish
  validates :intro_video_link,
            format:
              { with: VIDEO_LINK_REGEX,
                message: 'Niepoprawny format'
              },
            unless: 'intro_video_link.blank?'

  def publish
    return false unless save(context: :publish)

    update_attribute(:status, 'published')
  end

  def published?
    status == 'published'
  end

  def destroy(permament = false)
    if permament || status == 'deleted'
      super()
    else
      update_attribute(:status, 'deleted')
    end
  end

  def deleted?
    status == 'deleted'
  end

  def increase_popularity
    self.popularity += 1
  end

  def to_s
    name
  end

  def embed_intro_video_link
    return nil unless intro_video_link.present?
    intro_video_link.gsub('watch?v=', 'embed/') + video_params
  end

  def videos_count
    lessons.map { |lesson| lesson.videos.count }.reduce(:+)
  end

  protected

  def validate_link
    unless intro_video_link.to_s.empty?
      self.intro_video_link = validate_youtube_link(intro_video_link)
    end
  end
end
