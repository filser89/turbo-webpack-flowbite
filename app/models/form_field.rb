# frozen_string_literal: true

class FormField
  attr_reader :name

  #
  # Initalizes a new instance of FormField
  #
  # @param [Symbol] name a name of the attribute to modify
  # @param [Symbol] partial a name of a file
  # @param [Hash] options Options to modify the default behavior of the form
  #
  def initialize(name, partial, options = {})
    @name = name
    @partial = partial
    @options = options
  end

  def field_partial
    "admin/partials/form/#{partial}"
  end

  def collection
    options[:collection] || []
  end

  def prompt
    "Select #{humanized_name}"
  end

  def file_label
    "#{file_svg}<div><span class=\"font-semibold\">Click to upload </span> <span>or drag and drop #{humanized_name}</span></div><div class=\"text-xs mt-1\">Accepted: <span class=\"uppercase\">#{humanized_accept}</span/></div>".html_safe
  end

  def accept
    options[:accepted_formats].present? ? accept_value : nil
  end

  private

  attr_reader :partial, :options

  def humanized_accept
    accepted_formats.join(', ')
  end

  def accept_value
    accepted_formats.map { |format| ".#{format}" }.join(',')
  end

  def accepted_formats
    options[:accepted_formats]
  end

  def humanized_name
    name.to_s.humanize.downcase
  end

  def file_svg
    '<svg aria-hidden="true" class="mb-3 w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path></svg>'
  end
end
