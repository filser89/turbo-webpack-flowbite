module ApplicationHelper

  # returns array of controllers namespased with 'admin/' in form of 'products'
  def admin_controllers
    controllers = Rails.application.routes.routes.map do |route|
      route.defaults[:controller]
    end.uniq
    controllers.compact.select { |x| x.match? 'admin/' }.map { |x| x.gsub('admin/', '') }
  end

  # returns an index path of the specified controller or same controller
  # OPTIONS: controller - the admin controller name in form of 'products', pars: parameters of the link in for of hash
  def admin_index_path(options = {})
    controller = options[:controller] || controller_name
    args = [:"admin_#{controller}_path"]
    args << options[:pars] if options[:pars].present?
    public_send(*args)
  end

  def admin_show_path(options = {})
    controller = options[:controller] || controller_name
    args = [:"admin_#{controller.singularize}_path"]
    args << options[:pars] if options[:pars].present?
    public_send(*args)
  end
end
