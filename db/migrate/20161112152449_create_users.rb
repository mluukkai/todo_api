class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :token
      t.string :name

      t.timestamps null: false
    end
  end
end
