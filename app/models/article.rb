class Article < ActiveRecord::Base
  belongs_to :user

  validates :title,
            presence: { message: 'Tytuł nie może być pusty' }
  validates :body,
            presence: { message: 'Treść nie może być pusta' }
  validates :user_id, presence: true

  scope :newest, -> { order('created_at DESC') }

  def body_text
    body
  end

  def short_title
    title.truncate(50, separator: ' ')
  end

  def published_at
    created_at.strftime('%d.%m.%Y')
  end

  def author
    user.email
  end
end
