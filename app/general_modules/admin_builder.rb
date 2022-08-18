class AdminBuilder
  def self.require_models
    regex = %r{(?<=/app/models/).*(?=.rb)}
    Dir[File.join(Rails.root, 'app', 'models', '*.rb')].map { |file| file.match(regex).to_s.classify.constantize }
  end

  # defines the models that have admin index routes
  def self.admin_resources
    ApplicationRecord.descendants.map(&:admin_resources).flatten
  end

  def self.admin_resource(admin_resource_name)
    admin_resources.find { |admin_resource| admin_resource.name == admin_resource_name }
  end
end
