# frozen_string_literal: true

module Admin::DataHelper

  def build_value_from_hash(hash)
    val = ''
    hash.each_key { |k| val += "[#{k}][#{hash[k]}]"}
    val
  end

  # creates hidden inputs for the form to keep all the query params
  def hidden_query_inputs(f)
    @query_params.each_key do |qp|
      if @query_params[qp].present?
        next if qp == :per
        f.hidden_field qp
      end
    end
  end

  # merges existing params for sorting/pagination/filters with new query params
  def merged_params(new_params = {})
    # h = {resource_name: resource_name}.merge(new_params)
    @query_params.merge(new_params)
  end

  # checks if the mrethod is an association
  def is_assoc?(method)
    @model.reflect_on_association(strip_id(method)).present?
  end

  # checks if method is an attribute
  def is_attribute?(method)
    @model.new.attributes.keys.map(&:to_sym).include?(method)
  end

  # removes _id from method
  # :user_id => 'user'
  def strip_id(method)
    method.to_s.gsub(/_id/, '')
  end

  def resource_name
    @model.to_s.tableize
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
