class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:normal, :moderator, :admin]

  has_many :articles
  has_one :profile, dependent: :destroy

  validates :username, presence: true, on: :update

  after_create :generate_profile
  after_create :generate_username, if: proc { username.blank? }

  def can_view_admin_panel?
    admin? || moderator?
  end

  def to_s
    email
  end

  private

  def generate_username
    self.username = email.gsub(/\@.*/, '')
  end

  def generate_profile
    Profile.create(user: self) if profile.nil?
  end
end
