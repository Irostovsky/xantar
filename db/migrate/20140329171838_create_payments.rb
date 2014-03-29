class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :posts
      t.text :params
      t.boolean :success
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.datetime :card_expires_on
      t.timestamps
    end
  end
end
