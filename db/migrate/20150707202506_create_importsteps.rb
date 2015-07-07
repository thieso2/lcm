class CreateImportsteps < ActiveRecord::Migration
  def change
    create_table :importsteps do |t|
      t.references  :import
      t.string      :description
      t.integer     :totalrows
      t.integer     :validrows
      t.integer     :errorrows

      t.timestamps null: false
    end
  end
end
