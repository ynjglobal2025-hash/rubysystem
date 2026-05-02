class CreateSections < ActiveRecord::Migration[7.1]
  def change
    create_table :sections do |t|
      t.string  :title,       null: false
      t.text    :description
      t.integer :status,      null: false, default: 0
      t.integer :progress,    null: false, default: 0
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end

    add_index :sections, :status
    add_index :sections, :updated_at
  end
end
