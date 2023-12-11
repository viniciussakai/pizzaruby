class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :category
      t.boolean :status
      t.decimal :price

      t.timestamps
    end
  end
end
