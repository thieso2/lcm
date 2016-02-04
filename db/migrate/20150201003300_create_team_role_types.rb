class CreateTeamRoleTypes < ActiveRecord::Migration
  def change
    create_table :team_role_types do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
