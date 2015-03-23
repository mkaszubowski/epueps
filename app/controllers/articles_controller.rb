class ArticlesController < ApplicationController

  def index 
    @articles = Article.includes(:user).all
  end

  def show
    @article = Article.find(params[:id])
  end
end
