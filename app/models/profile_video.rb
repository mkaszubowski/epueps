class ProfileVideo < ActiveRecord::Base
  belongs_to :profile
  belongs_to :video

  validates :profile_id, presence: true
  validates :video_id, presence: true
  validates_uniqueness_of :video_id, scope: :profile_id
end
