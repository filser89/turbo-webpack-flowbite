class ListHeader
  attr_reader :method, :admin_search_path, :frame_name

  # do we need model here?
  def initialize(list_builder, method, options = {})
    @method = method
    @admin_search_path = list_builder.admin_search_path
    @frame_name = list_builder.frame_name
    @legacy_params = list_builder.legacy_params
    @options = options
    @sortable = options[:sortable] || true
  end

  def content
    options[:header_content] || method.to_s.humanize
  end

  def sortable?
    @sortable
  end

  def sort_params(order)
    return { q: { s: ["#{method} #{order}"] }, per: legacy_params[:per] } unless legacy_params[:q].present?

    { q: legacy_params[:q]&.merge({ s: ["#{method} #{order}"] }), per: legacy_params[:per] }
  end

  def sort_button_role(order)
    "sort-btn-#{method_part}-#{order}"
  end

  private

  attr_reader :options, :legacy_params

  def method_part
    method.to_s.gsub('_', '-')
  end
end
