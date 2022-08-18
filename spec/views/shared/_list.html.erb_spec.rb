require 'rails_helper'

RSpec.describe 'app/views/shared/_list.html.erb' do
  def list_options(model, parent = nil, legacy_params = {})
    {
      model:,
      relation: model.page(1),
      q: model.ransack,
      parent:,
      legacy_params:
    }
  end

  def create_items(model, count)
    create_list(model.to_s.downcase.to_sym, count)
  end

  context "when rendered on the first page" do
    it "has pagination buttons: page buttons, next page, last page, doesn't have first page and prev page" do
      create_items(Product, 50)
      list_options = list_options(Product)
      admin_resource = AdminResource.new(Product, { list_column_templates: [:name] })
      list_builder = ListBuilder.new(admin_resource, list_options)

      render partial: "shared/list", locals: { list_builder: }

      # checking that the relevant pagination buttons are rendered (no first and prev)
      expect(rendered).to have_tag(:nav, class: 'pagination') do
        without_tag('button[data-role=pagination-first]')
        without_tag('button[data-role=pagination-prev]')
        with_tag('button[data-role=pagination-page]')
        with_tag('button[data-role=pagination-next]')
        with_tag('button[data-role=pagination-last]')
      end
    end
  end
end
