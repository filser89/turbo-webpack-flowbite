class Student < ApplicationRecord
  include Administratable

  belongs_to :band_space

  admin_resource do
    form_fields do
      form_field :band_space, :instrument_radio_buttons, collection: BandSpace.all
    end
  end
end
