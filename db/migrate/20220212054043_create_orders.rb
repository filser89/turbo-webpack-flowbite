class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_enum :order_status, %w[created confirmed delivered completed]
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.enum :status, enum_type: :order_status, default: :created, null: false

      t.timestamps
    end
  end
end
