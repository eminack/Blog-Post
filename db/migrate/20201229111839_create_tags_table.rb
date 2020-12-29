class CreateTagsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.belongs_to :article
      t.belongs_to :user
      t.timestamps
    end
  end
end
