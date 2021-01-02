class RemoveIndexFromTags < ActiveRecord::Migration[5.2]
  def change
    remove_index :tags , name: "index_tags_on_article_id"
    remove_index :tags, name: "index_tags_on_user_id"
    add_index :tags , [:article_id, :user_id], :unique => true
  end
end
