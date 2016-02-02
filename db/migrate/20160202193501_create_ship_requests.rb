class CreateShipRequests < ActiveRecord::Migration
  def change
    create_table :ship_requests do |t|
      t.references :from_city,  references: :cities, index: true, foreign_key: true
      t.references :to_city,    references: :cities, index: true, foreign_key: true
      t.date :from_date
      t.date :until_date
      t.integer :size
      t.references :user, index: true, foreign_key: true
      t.integer :reward
      t.text :message

      t.timestamps null: false
    end
  end
end
