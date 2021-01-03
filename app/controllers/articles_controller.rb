class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit,:update,:show,:destroy]
    before_action :require_same_user, only: [:edit,:update,:destroy] 
    before_action :require_user , only: [:index,:show,:tagged]
    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            render :new
        end

    end

    def index
        @articles = Article.where(user_id: current_user).order('updated_at DESC').paginate(page: params[:page],per_page: 3)
    end
    
    def show
        @article = Article.find(params[:id])
        @tagged_users = @article.users
    end

    def edit

    end

    def update

        if @article.update(article_params)
            flash[:success] = "Article was successfully updated"
            redirect_to article_path(@article)
        end
    end

    def destroy
        @article.destroy
        flash[:danger] = "Article was successfully destroyed"
        redirect_to articles_path
    end

    def tagged
        @tagged_articles = current_user.articles.order('updated_at DESC').paginate(page: params[:page],per_page: 3)

    end

    private
        def article_params
            params.require(:article).permit(:title,:description)
        end

        def set_article
            @article = Article.find(params[:id])
        end

        def require_same_user
            if logged_in? && current_user != @article.user
                flash[:danger] = "You can only edit or delete your own articles"
                redirect_to root_path
            end
        end
end
