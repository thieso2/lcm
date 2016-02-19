class CreateEvents < ActiveRecord::Migration
  def change
    create_table(:events) do |t|
      t.belongs_to  :event_type, index: true
      t.references  :location

      t.string  :shortname
      t.string  :title
      t.date    :startdate
      t.date    :enddate,       null: true
      t.decimal :baseprice,     precision: 8, scale: 2
      t.integer :event_state,   null: false, default: 0

      t.timestamps
    end

    add_foreign_key :events, :event_types
    add_foreign_key :events, :locations
  end
end
