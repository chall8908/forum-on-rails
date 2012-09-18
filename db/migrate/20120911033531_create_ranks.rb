class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :name
      t.string :min_posts
      t.boolean :custom
      t.string :color
      t.string :image

      t.timestamps
    end
  end
end
