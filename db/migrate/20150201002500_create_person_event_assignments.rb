class CreatePersonEventAssignments < ActiveRecord::Migration
  def change
    create_table :person_event_assignments do |t|
      t.references :person,    index: true
      t.references :event,     index: true
      t.references :event_role_type, index: true

      t.date :startdate
      t.date :enddate

      t.timestamps
    end

    add_foreign_key :person_event_assignments, :people
    add_foreign_key :person_event_assignments, :events
    add_foreign_key :person_event_assignments, :event_role_types
  end
end
