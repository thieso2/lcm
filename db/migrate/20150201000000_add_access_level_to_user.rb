class AddAccessLevelToUser < ActiveRecord::Migration
  def change
      change_table(:users) do |t|
        t.integer :access
      end
  end
end
