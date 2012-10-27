class CreateAudits < ActiveRecord::Migration
  def change
    create_table :audits do |t|
      t.integer :site_id

      t.timestamps
    end
  end
end
