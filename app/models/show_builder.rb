class ShowBuilder
  attr_reader :admin_resource, :object

  def initialize(admin_resource, object)
    @admin_resource = admin_resource
    @object = object
  end

  def list_builders
    admin_resource.show_list_names.map do |list_name|
      ListBuilder.new(AdminBuilder.admin_resource(list_name), standard_list_options(list_name))
    end
  end

  # def objects(show_list)

  # end

  def standard_list_options(show_list_name)
    relation = object.public_send(show_list_name).page(1)
    {
      parent: object,
      relation:,
      q: relation.ransack({}),
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
