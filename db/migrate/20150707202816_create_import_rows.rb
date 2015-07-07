class CreateImportrows < ActiveRecord::Migration
  def change
    create_table :import_rows do |t|
      t.references  :import_steps
      t.integer     :row
      t.string      :rawdata
      t.string      :importdata
      t.string      :conflictdata
      t.integer     :state
      t.string      :message

      t.timestamps null: false
    end
  end
end
