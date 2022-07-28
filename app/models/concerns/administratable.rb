module Administratable
  extend ActiveSupport::Concern

  module ClassMethods

    def list_columns
      template[:list_column_templates] = []
      yield
    end

    def list_column(method, options = {})
      template[:list_column_templates] << [method, options]
    end

    def filters
      template[:filter_templates] = []
      yield
    end

    def filter(filter, options = {})
      template[:filter_templates] << [filter, options]
    end

    def show_lists
      template[:show_list_names] = []
      yield
    end

    def show_list(list_name)
      template[:show_list_names] << list_name
    end

    def admin_resources
      admin_resource_templates.map { |template| AdminResource.new(self, template) }
    end

    def admin_resource(name = nil)
      # @template = { list_column_templates: [], filter_templates: [], show_list_templates: [] }
      name = table_name.to_sym if name.blank?
      assign_template(name)
      yield
      admin_resource_templates << template
      clear_template
    end

    def admin_resource_templates
      @admin_resource_templates ||= []
    end

    def assign_template(name)
      @template = { name: }
    end

    def template
      @template
    end

    def clear_template
      remove_instance_variable(:@template)
    end
  end

  module InstanceMethods
    def list_column(method, options)
      ListColumn.new(self, method, options)
    end
  end

  module RelationMethods
    def list_rows(admin_resource)
      admin_resource = ApplicationRecord.admin_resource(admin_resource) if admin_resource.is_a? Symbol
      map do |x|
        admin_resource.list_column_templates.map { |template| x.list_column(*template) }
      end
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    ActiveRecord::Relation.send(:include, (RelationMethods))
    receiver.send :include, InstanceMethods
  end

end
