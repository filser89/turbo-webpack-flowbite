# frozen_string_literal: true

module Admin::DataHelper

  # checks if the mrethod is anassociation
  def is_assoc?(method)
    @model.reflect_on_association(strip_id(method)).present?
  end

  # removes _id from method
  def strip_id(method)
    method.to_s.gsub(/_id/, '')
  end

  # displays the association with one of the display methods or id
  def assoc_display(object, method)
    assoc = object.send(strip_id(method))
    display_methods = %i[full_name name last_name title email]
    display_method = display_methods.find {|m| assoc.respond_to?(m)} || :id
    assoc.send(display_method)
  end

  # :user => User
  def column_name(method)
    method.to_s.humanize
  end

  # Order => 'orders'
  def table_name
    @model.to_s.humanize.pluralize
  end

  # if the method is association builds a link to the show page of the association, otherwise displays the value
  def index_td_content(object, method, options = {})
    if is_assoc?(method)
      link_to assoc_display(object, method), admin_data_show_path(resource_name: strip_id(method).pluralize, id: object.send(method)), class: options[:class]
    else
      content_tag(:span, object.send(method), class: options[:class])
    end
  end

  def index_td(object, method, options = {})
    content_tag(:td, index_td_content(object, method), class: options[:class])
  end
end
