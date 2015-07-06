class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :event_type, index: true
      # t.has_one :location
      # t.add_foreign_key :locations
      t.references :location

      t.integer :eid            # old Event ID
      t.string  :shortname
      t.string  :title
      # t.string  :location
      t.date    :startdate
      t.date    :enddate,       null: true
      t.decimal :baseprice,     precision: 8, scale: 2
      t.integer :event_state,   null: false, default: 0

      t.timestamps null: false
    end
    add_foreign_key :events, :event_types

  end
end
