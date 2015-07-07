class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string      :fromfile
      t.datetime    :starttime
      t.datetime    :finishtime
      t.references  :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
