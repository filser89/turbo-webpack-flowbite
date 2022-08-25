class FormBuilder

  def initialize(admin_resource)
    @admin_resource = admin_resource
  end

  def model
    admin_resource.model
  end

  def form_fields
    admin_resource.form_field_templates.map { |template| FormField.new(*template) }
  end

  private

  attr_reader :admin_resource
end
