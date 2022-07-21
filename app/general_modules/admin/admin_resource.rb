module Admin::AdminResource

  module ClassMethods

    def column(method, options = {})
      list_columns_templates << [method, options]
      # @list_columns_templates << [method, options]
    end

    def list_columns(scope = nil)
      scope = :all if scope.blank?
      relation = send(*scope).extending do
        def trying
          map do |x|
            list_columns_templates.map { |template| x.list_column(*template) }
          end
        end
      end
      relation.trying
    end

    def list_columns_templates
      @list_columns_templates ||= []
    end
  end

  module InstanceMethods
    def list_column(method, options)
      ListColumn.new(self, method, options)
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
