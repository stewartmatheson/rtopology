class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :message
      t.integer :score
      t.integer :page_id
      t.integer :audit_id

      t.timestamps
    end
  end
end
