class AddColumnsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :ooa_es,  :boolean, default: false
    add_column :people, :ooa_sem, :boolean, default: false
  end
end
