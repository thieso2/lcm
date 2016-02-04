class CreatePersonTeamAssignments < ActiveRecord::Migration
  def change
    create_table :person_team_assignments do |t|
      t.references :person,    index: true
      t.references :team,     index: true
      t.references :team_role_type, index: true

      t.date :startdate
      t.date :enddate

      t.timestamps null: false
    end
    add_foreign_key :person_team_assignments, :people, primary_key: :pid
    add_foreign_key :person_team_assignments, :teams
    add_foreign_key :person_team_assignments, :team_role_types
  end
end
