class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.text :site_name
      t.text :description
      t.text :url
      t.integer :port

      t.timestamps
    end
  end
end
