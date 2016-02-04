class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.string :url_name
      t.string :description

      t.timestamps
    end
  end
end

