class StaticPagesController < ApplicationController
  # def home
  #   @splash = true unless user_signed_in?
  #   @subjects = Subject.published.popular.limit(3)
  # end

  def home
    @splash = true 
    @subjects = Subject.publushed.popular.limit(3)
    @articles = Article.includes(:user).all
  end
  
  def contact
  end

  def about
  end
end
