class AddFieldsToPeople < ActiveRecord::Migration
  def change
    change_table(:people) do |t|
      t.belongs_to :region

      # t.integer :pid

      t.string  :firstname
      t.string  :lastname
      t.string  :callby
      t.string  :sex
      t.string  :title
      t.string  :country
      t.string  :region
      t.string  :zip
      t.string  :city
      t.string  :street
      t.string  :housenumber
      t.date    :birthday

      t.string :phone_private
      t.string :phone_work
      t.string :phone_mobile

      t.string :notes

      t.boolean :do_not_contact


      t.integer :access
    end
  end
end
