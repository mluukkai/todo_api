class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.string :name
      t.string :description
      t.boolean :done
      t.integer :estimate
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
