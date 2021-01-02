class Article < ApplicationRecord
    belongs_to :user
    has_many :tags, dependent: :destroy
    has_many :users, through: :tags
    validates :title, presence: true, length:{minimum: 3,maximum: 50}
    validates :description, presence: true, length:{minimum: 1}
    validates :user_id, presence: true
end