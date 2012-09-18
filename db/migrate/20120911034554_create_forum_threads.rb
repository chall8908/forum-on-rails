class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.post :first_post
      t.string :title

      t.timestamps
    end
  end
end
