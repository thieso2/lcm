class CreateImportRows < ActiveRecord::Migration
  def change
    create_table :import_rows do |t|
      t.references  :import_step
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
