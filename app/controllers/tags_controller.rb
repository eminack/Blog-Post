class TagsController < ApplicationController
    before_action :set_article
    before_action :set_tagged_users
    before_action :require_user
    before_action :require_same_user
    
   
    def new

    end

    def search
        @query = params[:search][:query]
        if @query.blank?
            flash[:danger] = "Empty fields !"
            redirect_to article_tags_path
        else
            @search_results = User.all.where("lower(username) LIKE ? OR lower(username) LIKE ?","#{@query.downcase}%","%#{@query.downcase}")
            
        end

    end


    private
        def set_article
            @article = Article.find(params[:article_id])
        end

        def set_tagged_users
            @tagged_users = @article.users
        end

        def require_same_user
            if logged_in? && current_user != @article.user
                flash[:danger] = "You can only edit tags of your own articles"
                redirect_to root_path
            end
        end
end