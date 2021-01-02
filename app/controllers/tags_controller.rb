class TagsController < ApplicationController
    before_action :set_article
    before_action :set_tag_array , except: [:destroy]
    before_action :require_user
    before_action :require_same_user
    
    def index

    end
   
    def create
        @tag = Tag.new(tag_params)
        if @tag.save
            flash[:success] = "#{@tag.user.username} has been tagged successfully"
            redirect_to article_tags_path(@article)
        else
            redirect_to article_tags_path(@article)
        end

    end

    def search
        @query = params[:search][:query]
        if @query.blank?
            flash[:danger] = "Empty fields !"
            redirect_to article_tags_path
        else
            @search_results = User.select("username","id").where("lower(username) LIKE ? OR lower(username) LIKE ?","#{@query.downcase}%","%#{@query.downcase}")

            @results_array = @search_results.map(&:attributes)
            @tagged_array = @tag_array.map(&:attributes)
    
            @filter_results = []

            @results_array.each do |results_array_obj|
                flag = 1
                @tagged_array.each do |tagged_array_obj|
                    if results_array_obj["id"] == tagged_array_obj["user_id"] || results_array_obj["id"] == current_user.id
                        flag = 0
                        break
                    end
                end
                if results_array_obj["id"]!=current_user.id && flag == 1 
                    @filter_results.push(results_array_obj)
                end
            end
        end

    end

    def destroy
        tag = Tag.find(params[:id])
        user = tag.user
        tag.destroy
        flash[:success] = "User #{user.username} has been successfully removed"
        redirect_to article_tags_path(@article)
    end

    private
        def set_article
            @article = Article.find(params[:article_id])
        end

        def set_tag_array
            @tag_array = Tag.all.where(article: @article)
        end

        def tag_params
            params.permit(:user_id,:article_id)
        end

        def require_same_user
            if logged_in? && current_user != @article.user
                flash[:danger] = "You can only edit tags of your own articles"
                redirect_to root_path
            end
        end
end