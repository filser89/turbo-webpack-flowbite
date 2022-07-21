require 'action_view'

class TableBuilder
  include ActionView::Helpers::TagHelper

  def initialize(relation, model)
    @relation = relation
    @model = model
  end

  def list_rows
    relation.list_columns
  end

  def trs
    safe_join(list_rows.map { |row| content_tag(:tr, safe_join(row.map(&:td))) })
  end

  def tbody
    content_tag(:tbody, trs)
  end

  private

  attr_reader :relation

end
