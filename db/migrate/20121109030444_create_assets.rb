class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :page_id
      t.integer :size
      t.string :path
      t.string :md5
      t.string :asset_type

      t.timestamps
    end
  end
end
