class StaticPagesController < ApplicationController
  def home
    @splash = true
    @subjects = Subject.published.popular.limit(3)
    @articles = Article.includes(:user).newest.limit(4).decorate
  end

  def contact
  end

  def about
  end
end
