class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :path
      t.integer :site_id
      t.integer :discovered_id

      t.timestamps
    end
  end
end
