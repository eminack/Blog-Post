class ArticlesController < ApplicationController
    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save
            flash[:success] = "Article was successfully created"
            redirect_to article_path(@article)
        else
            render :new
        end

    end

    def show
        
    end

    private
        def article_params
            params.require(:article).permit(:title,:description)
        end
end
