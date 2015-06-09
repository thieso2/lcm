class CreatePersonEventAssignments < ActiveRecord::Migration
  def change
    create_table :person_event_assignments do |t|
      t.references :person,    index: true
      t.references :event,     index: true
      t.references :event_role_type, index: true

      t.date :startdate
      t.date :enddate

      t.timestamps null: false
    end
    add_foreign_key :assignments, :People
    add_foreign_key :assignments, :Events
    add_foreign_key :assignments, :EventRoleTypes
  end
end
