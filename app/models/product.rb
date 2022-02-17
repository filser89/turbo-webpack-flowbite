class Product < ApplicationRecord
  def self.index_methods
    %i[name description quantity created_at updated_at caps_name]
  end

  def caps_name
    name.upcase
  end
end
