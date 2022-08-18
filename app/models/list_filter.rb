class ListFilter
  attr_reader :list_builder, :method, :options

  def initialize(list_builder, method, options = {})
    @list_builder = list_builder
    @method = method
    @options = options
  end

  def filter_tag
    content_tag(:div)
  end

  def predicates
    options[:predicates] || default_predicates
  end

  def collection
    return assoc_model.all if assoc?
    model.public_send(method.to_s.pluralize).keys if enum?
  end

  def assoc_display_method
    assoc_model.display_method
  end

  def assoc?
    model.reflect_on_association(method).present?
  end

  def enum?
    data_type == :enum
  end

  def string?
    data_type == :string
  end

  def numeric?
    data_type.in? %i[integer float]
  end

  def date?
    data_type.in? %i[date datetime]
  end


  private

  def assoc_model
    model.reflect_on_association(method).class_name.constantize if assoc?
  end




  # returns an array of predicates based on the data type
  def default_predicates
    # string - cont, eq, start_with, end_with
    # integer / float - eq, greater than, less than
    # date / From - To date
    # boolean
    # select
    return %i[cont] if data_type == :string
    return %i[eq gt lt] if data_type == :integer
  end

  def array?
    column_for_attribute.array?
  end

  def data_type
    # find out what data type is returned by method
    # if attribute?
    column_for_attribute.type
  end

  def attribute?
    model.new.attributes.keys.map(&:to_sym).any? { |key| key == method }
  end

  def model
    list_builder.model
  end


  def column_for_attribute
    model.column_for_attribute(method)
  end
end

# f.label :"#{method}_cont"
# f.search_field :"#{method}_cont"


# ListFilter provides filter functionality
# Each ListFilter instance is a set of predicates to be applied to the given method
# set default predicates based on data_type of the return of the method
# * string - A drop down for selecting “Contains”, “Equals”, “Starts with”, “Ends with” and an input for a value.
# * :date_range - A start and end date field with calendar inputs
# * :numeric - A drop down for selecting “Equal To”, “Greater Than” or “Less Than” and an input for a value.
# * :select - A drop down which filters based on a selected item in a collection or all.
# * :check_boxes - A list of check boxes users can turn on and off to filter
#
