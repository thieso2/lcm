class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :person,    index: true
      t.references :group,     index: true
      t.references :role_type, index: true
      
      t.date :startdate
      t.date :enddate

      t.timestamps null: false
    end
    add_foreign_key :assignments, :People
    add_foreign_key :assignments, :Groups
    add_foreign_key :assignments, :RoleTypes
  end
end
