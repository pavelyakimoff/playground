class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :surname
      t.integer :phone

      t.timestamps
    end
  end
end
