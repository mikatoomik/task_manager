class CreateTasts < ActiveRecord::Migration[8.0]
  def change
    create_table :tasts do |t|
      t.string :title
      t.text :description
      t.references :list, null: false, foreign_key: true
      t.integer :position
      t.boolean :completed, default: false
      t.datetime :completed_at
      t.datetime :due_at

      t.timestamps
    end
  end
end
