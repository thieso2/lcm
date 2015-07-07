class CreateImportrows < ActiveRecord::Migration
  def change
    create_table :importrows do |t|
      t.references  :importsteps
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
