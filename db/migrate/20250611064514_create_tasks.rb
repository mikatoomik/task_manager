class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :list, null: false, foreign_key: true
      t.integer :position
      t.boolean :completed

      t.timestamps
    end
  end
end
