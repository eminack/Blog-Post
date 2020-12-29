class User < ApplicationRecord
    has_many :articles
    has_many :tags
    has_many :articles, through: :tags
    before_save {self.email = email.downcase}

end