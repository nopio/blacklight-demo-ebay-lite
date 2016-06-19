class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :category_id
      t.text :description
      t.integer :condition
      t.float :price
      t.integer :format
      t.integer :brand_id
      t.float :screen_size
      t.integer :color
      t.integer :memory

      t.timestamps null: false
    end
  end
end
