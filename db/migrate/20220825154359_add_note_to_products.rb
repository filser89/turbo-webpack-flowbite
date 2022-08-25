class AddNoteToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :note, :text
  end
end
