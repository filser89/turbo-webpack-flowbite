class ShowBuilder
  attr_reader :admin_resource, :object

  def initialize(admin_resource_name, object)
    @admin_resource = AdminBuilder.admin_resource(admin_resource_name.to_sym)
    @object = object
  end

  def list_builders
    admin_resource.show_list_names.map { |list_name| ListBuilder.new(list_name, standard_list_options(list_name)) }
  end

  def objects(show_list)

  end

  def standard_list_options(show_list_name)
    objects = object.public_send(show_list_name).page(1)
    {
      parent: object,
      objects:,
      q: objects.ransack({}),
      legacy_params: {}
    }
  end

  def h1
    content_tag(:h1, header_content)
  end

  def header_content
    admin_resource.name.to_s.humanize
  end

  # list_options:
  # objects - the relation
  # parent - only for show page, the object of the show page
  # q - ransack object
  # legacy_params - {}, contains info about previously applied sorting, filters and pagination params
end
