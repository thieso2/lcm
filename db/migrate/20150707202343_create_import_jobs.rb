class CreateImportJobs < ActiveRecord::Migration
  def change
    create_table :import_jobs do |t|
      t.string      :original_filename
      t.string      :temp_filename
      t.datetime    :starttime
      t.datetime    :finishtime

      t.belongs_to  :person, index: true, foreign_key: {primary_key: :pid}

      t.timestamps null: false
    end
  end
end
