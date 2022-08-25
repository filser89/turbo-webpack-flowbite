class Admin::BaseController < ApplicationController
  before_action :set_model
  before_action :set_parent, only: %i[index search], if: :parent?
  before_action :set_object, only: %i[show update destroy]
  before_action :set_legacy_params, only: %i[index search]
  # before_action :set_lists_list_options, only: %i[show]
  before_action :set_show_builder, only: %i[show]
  rescue_from ActionController::MissingExactTemplate, with: :standard_view

  def index
    base = @parent.present? ? @parent.public_send(@model.to_table_sym) : @model
    @q = base.ransack(params[:q])
    @queries = %i[result index_set]
    paginate_objects
    p "===========@queries", @queries
    p @objects = @queries.inject(@q) { |o, a| o.send(*a) }
    set_list_options
    admin_resource = AdminBuilder.admin_resource(controller_name.to_sym)
    p "=====================================================", admin_resource
    p controller_name
    @list_builder = ListBuilder.new(admin_resource, @list_options)
  end

  def show; end

  def new
    @object = @model.new
    @admin_resource = AdminBuilder.admin_resource(controller_name.to_sym)
    @form_builder = FormBuilder.new(@admin_resource)
  end

  def create
    @object = @model.new(permitted_params)
  end

  def edit
  end

  def search
    index
    render :index
  end

  private

  def set_list_options
    @list_options = {
      relation: @objects,
      parent: @parent,
      q: @q,
      legacy_params: @legacy_params,
      model: @model
    }
  end

  def set_legacy_params
    @legacy_params = {
      per: params[:per],
      q: {}
    }
    p '====================================='
    @legacy_params[:q] = params[:q].to_unsafe_h if params[:q].present?
  end

  def paginate_objects
    @queries << [:page, params[:page]]
    @queries << [:per, params[:per]]
  end

  def set_model
    # 'users' => User
    @model = params[:model]&.s_to_model || controller_name.s_to_model
  end

  def set_object
    # Take model from "set_model"
    # User.find(1)
    @object = @model.find(params[:id])
  end

  def set_parent
    parent_model = params[:parent_model].s_to_model
    parent_id = params[params[:parent_model].foreign_key]
    @parent = parent_model.find(parent_id)
  end

  def parent?
    params[:parent_model].present?
  end

  def set_show_builder
    admin_resource = AdminBuilder.admin_resource(controller_name.to_sym)
    @show_builder = ShowBuilder.new(admin_resource, @object)
  end

  # creates instance_variables i.e @products_list_options in order to render show lists of @object
  def set_lists_list_options
    @object.show_lists.each do |list|
      relation = @object.public_send(list).page(1)
      list_options = {
        model: list.s_to_model,
        relation:,
        parent: @object,
        q: objects.ransack({}),
        legacy_params: {},
        # table_builder: TableBuilder.new(objects)
      }
      instance_variable_set(:"@#{list}_list_options", list_options)
    end
  end

  # render a standard view from a base folder if there is no specific template
  def standard_view
    render "admin/base/#{action_name}"
  end
end
