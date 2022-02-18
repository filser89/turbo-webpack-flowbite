class Admin::DataController < ApplicationController
  before_action :set_model, only: %i[index show create update destroy]
  before_action :set_object, only: %i[show update destroy]
  def index
    @objects = @model.all
  end

  def show
  end

  def new
  end

  def edit
  end

  private

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
