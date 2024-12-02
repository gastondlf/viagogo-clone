class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :ticket_number
      t.float :price
      t.string :status
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
