class ArticleDecorator < Draper::Decorator
  delegate_all

  def published_at
    l(article.created_at.to_date, format: :long)
  end

  def paragraphs(count)
    object
      .body
      .gsub('</p>', '')
      .split('<p>')
      .reject(&:blank?)
      .first(count)
  end
end