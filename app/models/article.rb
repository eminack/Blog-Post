class Article < ApplicationRecord
    belongs_to :user
    has_many :tags
    has_many :users, through: :tags
end