class Admin::BaseController < ApplicationController
  before_action :set_model, only: %i[index search show create update destroy]
  before_action :set_parent, only: %i[index search], if: :parent?
  before_action :set_object, only: %i[show update destroy]
  before_action :set_lists_variables, only: %i[show]
  before_action :destructure_params, only: %i[index search]
  rescue_from ActionController::MissingExactTemplate, with: :standard_view

  def index
    # change model to base (on _list bartial and all the helpers)
    # find a way to set base not from controller name

    base = @parent.present? ? @parent.public_send(@model.model_name.plural) : @model
    @q = base.ransack(params[:q])
    @queries = %i[result index_set]
    sort_objects # if params[:order].present? && params[:sort_by].present?
    paginate_objects
    # ransack_objects
    p "===========@queries", @queries
    p @objects = @queries.inject(@q) { |o, a| o.send(*a) }
    @list_options = {
      model: @model,
      objects: @objects,
      parent: @parent,
      q: @q,
      query_params: @query_params
    }
  end

  def show; end

  def new
  end

  def edit
  end

  def search
    index
    render :index
  end

  private

  # def ransack_objects
  #   @queries << :ransack
  # end

  # converts json to a hash if possible or returns a value
  def parse_json_if_can(val)
    return val unless val.is_a? String

    JSON.parse(val)
  rescue JSON::ParserError => _e
    val
  end

  def set_sort_params
    sp = parse_json_if_can(params[:sort_params])
    p 'sp================', sp
    pars = {}
    sp.each_key { |k| pars[k.to_sym] = sp[k] }
    p '===================pars', pars
    pars
  end

  def destructure_params
    @sort_params = set_sort_params if params[:sort_params].present?
    set_query_params
  end

  def set_query_params
    @query_params = {
      sort_params: @sort_params,
      per: params[:per]
    }
  end

  def sort_objects
    return unless @sort_params.present?

    @queries << [:order, { @sort_params[:sort_by] => @sort_params[:order] }]
  end

  def paginate_objects
    @queries << [:page, params[:page]]
    @queries << [:per, params[:per]]
  end

  def set_model
    # 'users' => User
    @model = params[:model] || controller_name.classify.constantize
  end

  def set_object
    # Take model from "set_model"
    # User.find(1)
    @object = @model.find(params[:id])
  end

  def set_parent
    parent_model = params[:parent_model]
    parent_id = params["#{parent_model.model_name.singular}_id"]
    @parent = parent_model.find(parent_id)
  end

  def parent?
    params[:parent_model].present?
  end

  # creates instance_variables in order to render show lists of a @object
  def set_lists_variables
    @object.show_lists.each do |list|
      instance_variable_set(:"@#{list}", @object.public_send(list).page(1))
      instance_variable_set(:"@#{list}_q", instance_variable_get(:"@#{list}").ransack({}))
      instance_variable_set(:"@#{list}_model", list.to_s.singularize.capitalize.constantize)
    end
  end

  # render a standard view from a base folder if there is no specific template
  def standard_view
    render "admin/base/#{action_name}"
  end
end
