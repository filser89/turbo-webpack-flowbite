class AddRankToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :rank, :integer, array: true, default: []
  end
end
