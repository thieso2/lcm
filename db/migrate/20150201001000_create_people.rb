class CreatePeople < ActiveRecord::Migration
  def change
    create_table(:people) do |t|
      t.belongs_to :region

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

      t.string  :email

      t.string  :state # "Status"
      t.string  :date # "Datum"

      t.string :phone_private
      t.string :phone_work
      t.string :phone_mobile

      t.text   :notes

      t.boolean :do_not_contact
    end
  end
end
