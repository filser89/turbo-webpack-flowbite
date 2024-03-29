# it should help build list partial on admin based on the admin_resource and relation
# admin_resource can be taken from controller name upon ListBuilder.new() in controller
# relation is objects

# list_options:
# objects - the relation
# parent - only for show page, the object of the show page
# q - ransack object
# legacy_params - {}, contains info about previously applied sorting, filters and pagination params


require 'action_view'

#
# Class ListBuilder provides <description>
#
# @author Joe Blog <Joe.Blog@nowhere.com>
#
class ListBuilder
  include ActionView::Helpers::TagHelper

  attr_reader :admin_resource, :relation, :model, :parent, :legacy_params, :q

  def initialize(admin_resource, list_options)
    @admin_resource = admin_resource
    @relation = list_options[:relation]
    @model = admin_resource.model
    @parent = list_options[:parent]
    @q = list_options[:q]
    @legacy_params = list_options[:legacy_params]
  end

  def table_header
    admin_resource.name.to_s.humanize.pluralize
  end

  def frame_name
    return "search-#{resource_part}" unless parent?

    "search-#{parent_part}-#{resource_part}"
  end

  def table_id
    return "#{resource_part}-table" unless parent?

    "#{parent_part}-#{resource_part}-table"
  end

  def parent?
    parent.present?
  end

  def list_headers
    admin_resource.list_column_templates.map { |template| ListHeader.new(self,  *template) }
  end

  def list_rows
    relation.map do |x|
      admin_resource.list_column_templates.map { |template| x.list_column(*template) }
    end
  end

  def trs
    safe_join(list_rows.map { |row| content_tag(:tr, safe_join(row.map(&:td))) })
  end

  def tbody
    content_tag(:tbody, trs)
  end

  def list_filters
    admin_resource.list_filter_templates.map { |template| ListFilter.new(self, *template) }
  end

  def filter_form_params
    new_q = { q: legacy_params[:q].slice(:s) }
    legacy_params.merge(new_q)
  end

  def paginate_locals
    { list_paginator: }
  end

  def list_paginator
    ListPaginator.new(self)
  end

  def admin_search_path
    args = ["search_admin_#{resource_part}_path"] unless parent.present?
    args = ["search_admin_#{parent_part}_#{resource_part}_path", parent.id] if parent.present?
    # args << options[:pars] if options[:pars].present?
    router = Rails.application.routes.url_helpers
    router.public_send(*args)
  end


  def per_page_role
    return "#{resource_part}-per-page" unless parent?

    "#{parent_part}-#{resource_part}-per-page"
  end

  private

  # maybe change later
  def parent_part
    parent.class.to_element_s
  end

  def resource_part
    admin_resource.name
  end


  # table_id(model, parent)
  # table_headers (model.list_header)
  # tbody
  # pagination locals







end
