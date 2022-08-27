class CreateBandSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :band_spaces do |t|
      t.string :instrument

      t.timestamps
    end
  end
end
