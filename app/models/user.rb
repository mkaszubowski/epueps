class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:normal, :moderator, :admin]

  has_many :articles

  def to_s
    email
  end
end
