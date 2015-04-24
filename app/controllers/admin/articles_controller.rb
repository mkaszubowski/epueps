module Admin
  class ArticlesController < BaseController
    load_and_authorize_resource

    def index
      @articles = SortAndFilterData.call(Article.includes(:user), params)
    end

    def new
      @article = Article.new
    end

    def create
      @article = current_user.articles.build(article_params)

      if @article.save
        flash[:success] = 'Dodano artykuł'
        redirect_to admin_articles_path
      else
        flash[:error] = 'Wystąpił błąd'
        render 'new'
      end
    end

    def update
      if @article.update_attributes(article_params)
        flash[:success] = 'Zapisano zmiany'
        redirect_to admin_articles_path
      else
        flash[:error] = 'Wystąpił błąd'
        render 'edit'
      end
    end

    def destroy
      if @article.destroy
        flash[:success] = 'Usunięto artykuł'
      else
        flash[:success] = 'Wystąpił błąd. Spróbuj ponownie później.'
      end

      redirect_to admin_articles_path
    end

    private

    def article_params
      params.require(:article).permit(:title, :body, :user_id)
    end

    def set_article
      @article = Article.find(params[:id])
    end
  end
end
