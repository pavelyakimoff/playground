class AddDefaultValueToLevel < ActiveRecord::Migration
  def up
    change_column :developers, :level, :integer, :default => 0
  end

  def down
    change_column :developers, :level, :integer, :default => nil
  end
end
