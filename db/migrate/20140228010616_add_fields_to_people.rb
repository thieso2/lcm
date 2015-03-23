class AddFieldsToPeople < ActiveRecord::Migration
  def change
    change_table(:people) do |t|
      t.string  :firstname
      t.string  :lastname
      t.integer :sex
      t.integer :salutation
      t.string  :country
      t.string  :region
      t.string  :zip
      t.string  :city
      t.string  :street
      
      t.string :phone_private
      t.string :phone_work
      t.string :phone_mobile

      t.string :notes
      
      t.integer :pid  
      t.boolean :do_not_contact
      
      
      t.integer :access
    end
  end
end
