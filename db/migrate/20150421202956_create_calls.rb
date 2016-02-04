class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.belongs_to  :person, index: true

      t.datetime    :date
      t.integer     :caller_id, index: true
      t.text        :info
      t.timestamps null: false
    end

    add_foreign_key :calls, :people, column: :caller_id, primary_key: :pid
  end
end
