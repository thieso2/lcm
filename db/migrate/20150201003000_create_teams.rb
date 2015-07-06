class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.belongs_to :team_type, index: true
      t.references :region

      t.integer :tid            # old Event ID
      t.string  :shortname
      t.string  :title
      t.date    :startdate
      t.date    :enddate,       null: true

      t.timestamps null: false
    end
    add_foreign_key :teams, :team_types

  end
end
