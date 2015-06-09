class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string  :code,   null: false
      t.string  :city,   null: false
      t.text    :address

      t.timestamps       null: false
    end
  end
end
