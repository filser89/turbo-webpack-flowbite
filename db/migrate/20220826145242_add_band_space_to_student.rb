class AddBandSpaceToStudent < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :band_space, null: false, foreign_key: true
  end
end
