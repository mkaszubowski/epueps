class Subject < ActiveRecord::Base
  extend FriendlyId
  include YoutubeUtilities
  
  has_many :lessons, dependent: :destroy

  before_save :validate_link

  friendly_id :name, use: [:slugged, :finders]

  mount_uploader :image, SubjectImageUploader

  scope :popular,     -> { order('popularity DESC') }
  scope :recent,      -> { order('created_at DESC') }
  scope :deleted,     -> { where(status: 'deleted') }
  scope :published,   -> { where(status: 'published') }
  scope :drafts,      -> { where(status: 'draft') }
  scope :not_deleted, -> { where("status != 'deleted'") }

  validates :name, 
            presence: { message: "Nazwa nie może być pusta" },
            on: :publish
  validates :description, 
            presence: {message: "Opis nie może być pusty"},
            on: :publish
  validates :intro_video_link, 
            format: 
              { with: VIDEO_LINK_REGEX,
                message: "Niepoprawny format"
              },
            unless: "intro_video_link.blank?"
  

  def image_src
    if self.image_name
      "subjects/#{self.image_name}" 
    else
      "subjects/subject-#{self.id}.jpg"
    end
  end

  def publish
    return false unless self.save(context: :publish)
    
    self.update_attribute(:status, "published")
  end

  def published?
    status == "published"
  end

  def destroy(permament=false)
    if permament || status == "deleted"
      super()
    else
      self.update_attribute(:status, "deleted")
    end
  end

  def deleted?
    status == "deleted"
  end

  def increase_popularity
    self.popularity += 1
  end

  def to_s
    name
  end


  protected

  def validate_link
    unless intro_video_link.nil?
      self.intro_video_link = validate_youtube_link(self.intro_video_link)
    end
  end
end
