class AddLastSoldDateToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :last_sold_date, :date
  end
end
