class ListPaginator

  attr_reader :admin_search_path

  def initialize(list_builder)
    @admin_search_path = list_builder.admin_search_path
    @frame_name = list_builder.frame_name
    @legacy_params = list_builder.legacy_params
    @remote = true
  end

  def first_page_button_options(per_page)
    # {remote: remote, params: { page: 1, per: per_page }.merge(legacy_params), data: {turbo_frame: frame_name(model, parent)} , class: 'py-2 px-3 leading-tight text-gray-500 bg-white rounded-l-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white' }

    {
      remote:,
      data:,
      params: first_page_button_params(per_page),
      class: first_page_button_classes
    }
  end

  def prev_page_button_options(page, per_page)
    # {params:{page: prev_page, per: per_page}.merge(legacy_params), data:{turbo_frame: frame_name(model, parent)} ,rel: 'prev', remote: remote, class: 'py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white'  }

    {
      remote:,
      data:,
      params: prev_page_button_params(page, per_page),
      class: prev_page_button_classes
    }
  end

  def page_button_options(page, per_page)
    # {remote: remote, params:{page:, per: per_page}.merge(legacy_params), data:{turbo_frame: frame_name(model, parent)}, rel: page.rel, class: page.current? ? current_classes : classes, aria: {current: "#{page.current? ? 'page' : ''}"} }

    {
      remote:,
      data:,
      params: page_button_params(page, per_page),
      class: page.current? ? current_page_button_classes : page_button_classes,
      rel: page.rel,
      aria: { current: page.current? ? 'page' : '' }
    }
  end

  def next_page_button_options(page, per_page)
    # {params:{page: next_page, per: per_page}.merge(legacy_params), data:{turbo_frame: frame_name(model, parent)}, rel: 'next', remote: remote, class: 'py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white' }

    {
      remote:,
      data:,
      params: next_page_button_params(page, per_page),
      class: next_page_button_classes,
      rel: 'next'
    }
  end

  def last_page_button_options(total_pages, per_page)
    # {remote: remote, params:{page: total_pages, per: per_page}.merge(legacy_params), data:{turbo_frame: frame_name(model, parent)}, class: 'py-2 px-3 leading-tight text-gray-500 bg-white rounded-r-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white' }

    {
      remote:,
      data:,
      params: last_page_button_params(total_pages, per_page),
      class: last_page_button_classes
    }
  end

  private

  attr_reader :legacy_params, :remote, :frame_name

  def first_page_button_params(per_page)
    legacy_params.merge(page: 1, per: per_page)
  end

  def prev_page_button_params(page, per_page)
    legacy_params.merge(page: page - 1, per: per_page)
  end

  def page_button_params(page, per_page)
    legacy_params.merge(page:, per: per_page)
  end

  def next_page_button_params(page, per_page)
    legacy_params.merge(page: page + 1, per: per_page)
  end

  def last_page_button_params(total_pages, per_page)
    legacy_params.merge(page: total_pages, per: per_page)
  end

  def first_page_button_classes
    'py-2 px-3 leading-tight text-gray-500 bg-white rounded-l-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white'
  end

  def prev_page_button_classes
    "py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
  end

  def current_page_button_classes
    "py-2 px-3 text-blue-600 bg-blue-50 border border-gray-300 hover:bg-blue-100 hover:text-blue-700 dark:border-gray-700 dark:bg-gray-700 dark:text-white"
  end

  def page_button_classes
    "py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
  end

  def next_page_button_classes
    "py-2 px-3 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
  end

  def last_page_button_classes
    "py-2 px-3 leading-tight text-gray-500 bg-white rounded-r-lg border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white"
  end

  def data
    { turbo_frame: frame_name }
  end

  def next_page(page)
    page + 1
  end
end
