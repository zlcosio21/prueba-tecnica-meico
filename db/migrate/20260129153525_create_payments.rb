class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.decimal :amount, null: false
      t.string :currency, null: false
      t.string :payment_type, null: false
      t.json :details, null: false

      t.string :internal_id, null: false
      t.string :provider_reference, null: false
      t.string :status, null: false, default: "pending"

      t.timestamps
    end
  end
end
