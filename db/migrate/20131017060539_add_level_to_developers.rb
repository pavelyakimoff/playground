class AddLevelToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :level, :integer
  end
end
