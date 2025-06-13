class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :list, null: false, foreign_key: true
      t.integer :position
      t.integer :priority, default: 0, null: false
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end
end
