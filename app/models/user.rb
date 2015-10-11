class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:normal, :moderator, :admin]

  has_many :articles

  validates :username, presence: true, on: :update

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
end
