class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.text :description
      t.string :status
      t.integer :quantity
      t.references :user, null: false, foreign_key: true
      t.references :ticket_category, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
