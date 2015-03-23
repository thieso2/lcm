class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :group_type, index: true
      
      t.integer :eid            # old Event ID
      t.string  :shortname
      t.string  :title
      t.string  :location
      t.date    :startdate
      t.date    :enddate,       null: true
      t.decimal :baseprice,     precision: 8, scale: 2
      t.integer :group_state,   null: false, default: 0

      t.timestamps null: false
    end
    add_foreign_key :groups, :group_types

  end
end
