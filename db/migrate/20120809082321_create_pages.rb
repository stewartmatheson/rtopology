class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :path
      t.integer :site_id
      t.integer :discovered_id
      t.integer :response_time
      t.integer :response_code
      t.datetime :last_audited_at
      t.string :last_error
      t.datetime :last_error_at

      t.timestamps
    end
  end
end
