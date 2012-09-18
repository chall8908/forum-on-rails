class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.boolean :visible
      t.integer :status

      t.timestamps
    end
  end
end
