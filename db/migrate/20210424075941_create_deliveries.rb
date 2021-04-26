class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :post_code,      null: false
      t.integer :prefecture_id, null: false
      t.string :address,        null: false
      t.string :municipality,   null: false
      t.string :building_name
      t.string :phone_num,      null: false
      t.references :order,      foreign_key: true
      t.timestamps
    end
  end
end
