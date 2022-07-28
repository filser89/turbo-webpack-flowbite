class AdminResource
  attr_reader :model, :options, :name, :list_column_templates, :filter_templates, :show_list_names

  def initialize(model, options = {})
    @model = model
    @options = options
    @name = options[:name] || model.to_table_sym
    @list_column_templates = options[:list_column_templates] || []
    @filter_templates = options[:filter_templates] || []
    @show_list_names = options[:show_list_names] || []
  end

  def list_column_templates
    @list_column_templates ||= []
  end

  def show_lists
    show_list_names.map { |name| AdminBuilder.admin_resource(name) }.compact
  end

  def model_name
    model.name
  end

  def list_headers
    list_column_templates.map { |template| ListHeader.new(model, *template) }
  end

  def filters
    filter_templates.map { |template| ListFilter.new(*template) }
  end

  # What columns to create in the list
  # What filters to create on the list
  # What child lists to render on show

end
