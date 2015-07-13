class CreateImportSteps < ActiveRecord::Migration
  def change
    create_table :import_steps do |t|
      t.references  :import
      t.string      :description
      t.integer     :totalrows
      t.integer     :validrows
      t.integer     :errorrows

      t.timestamps null: false
    end
  end
end
