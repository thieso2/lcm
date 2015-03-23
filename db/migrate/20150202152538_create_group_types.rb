class CreateGroupTypes < ActiveRecord::Migration
  def change
    create_table :group_types do |t|
      t.string  :description, null: false
      t.integer :category,    null: false, default: 0

      t.timestamps null: false
    end
  end
end
