class AddColumnsToPerson < ActiveRecord::Migration
  def change
    add_column :people, :ooa_es, :boolean
    add_column :people, :ooa_sem, :boolean
  end
end
