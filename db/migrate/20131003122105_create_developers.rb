class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name
      t.string :surname
      t.integer :phone

      t.timestamps
    end
  end
end
