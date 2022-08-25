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
    "Select #{name.to_s.humanize.downcase}"
  end

  private

  attr_reader :partial, :options
end
