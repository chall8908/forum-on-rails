class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :title
      t.rank :primary_rank
      t.text :signature
      t.string :email
      t.hash :im_services

      t.timestamps
    end
  end
end
