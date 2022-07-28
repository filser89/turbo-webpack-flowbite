class ListFilter
  attr_reader :method, :options

  def initialize(method, options = {})
    @method = method
    @options = options
  end

  def filter_tag
    content_tag(:div)
  end

  def predicates


  end

  def default_predicates
    # string
    # integer / float
    # date
    # boolean
    # select
  end

  def data_type
    # find out what data type is returned by method
  end
end

# f.label :"#{method}_cont"
# f.search_field :"#{method}_cont"
