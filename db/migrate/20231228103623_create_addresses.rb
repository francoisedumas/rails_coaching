class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :line1
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code

      t.timestamps
    end
  end
end
