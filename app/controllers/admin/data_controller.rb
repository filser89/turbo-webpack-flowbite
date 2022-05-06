class Admin::DataController < ApplicationController
  before_action :set_model, only: %i[index show create update destroy]
  before_action :set_object, only: %i[show update destroy]
  before_action :destructure_params, only: %i[index]

  def index
    @q = @model.ransack(params[:q])
    @queries = [:result, :index_set]
    sort_objects# if params[:order].present? && params[:sort_by].present?
    paginate_objects
    # ransack_objects
    p "===========@queries", @queries
    @objects = @queries.inject(@q) { |o, a| o.send(*a) }
  end

  def show
  end

  def new
  end

  def edit
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
    set_legacy_params
  end

  def set_legacy_params
    @legacy_params = {
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
    # # /api/v1/:name
    #     # /api/v1/users
    #     # => User
    #     # Make an array of all DB table_names
    #     db_index = Hash[ActiveRecord::Base.connection.tables.collect do |c|
    #                       [c, c.classify]
    #     end ].except('schema_migrations', 'ar_internal_metadata')
    #     # Take the tablename, and make the Model of the relative table_name
    #     @model = db_index[params[:name]].constantize # "users" => User
    @model = params[:resource_name].classify.constantize
  end

  def set_object
    # Take model from "set_model"
    # User.find(1)
    @model.find(params[:id])
  end
end
