require 'rails_helper'

class TestClass < ApplicationRecord
  def self.load_schema!
    @columns_hash = {}
  end

end

RSpec.describe 'app/views/shared/_list.html.erb' do
  it 'renders a table of a given resource with columns specified in resource.class index_methods' do
    # model = TestClass
    # resource1 = double(column1: 'res1-col1', column2: 'res1-col2', column3: 'res1-col3')

    # # resource1 = TestClass.new
    # resource2 = double(column1: 'res2-col1', column2: 'res2-col2', column3: 'res2-col3')

    # objects = double(self: [resource1, resource2], total_pages: 1)
    # allow(model).to receive(:all).and_return(objects)


    # expect(rendered).to have_selector("table")
    3.times { create(:product) }
    q = Product.ransack
    objects = q.result.index_set.page(1)

    render partial: "shared/list", locals: { model: Product, objects: , parent: nil, legacy_params: {}, q: }

    expect(rendered).to have_selector("table tbody tr", count: 3)
    expect(rendered).to have_selector("table#products-table")
  end
end
