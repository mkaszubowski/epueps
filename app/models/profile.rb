class Profile < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true

  has_many :profile_videos
  has_many :watched_videos, through: :profile_videos, source: :video
end
