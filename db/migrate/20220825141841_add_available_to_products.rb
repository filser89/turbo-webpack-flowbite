class AddAvailableToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :available, :boolean, null: false, default: true
  end
end
