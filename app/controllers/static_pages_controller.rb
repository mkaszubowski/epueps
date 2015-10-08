class StaticPagesController < ApplicationController
  def home
    @splash = true unless user_signed_in?
    @subjects = Subject.published.popular.limit(3)
    @articles = Article.limit(3).decorate
    @recommended_article = Article.first.decorate
  end

  def contact
  end

  def about
  end
end
