class UserMailer < ApplicationMailer
    
    def new_user_mail
        @user = params[:user]
        @article = params[:article]
        mail(to: @user.email,subject: "New Article Tag by #{@article.user.username}")
    end
end
