class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name
      t.integer :sender_id
      t.integer :recipient_id
      t.string :recipient_phone
      t.string :amount
      t.boolean :redeemed

      t.timestamps
    end
  end
end
