class ToggleInput < SimpleForm::Inputs::BooleanInput
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    if nested_boolean_style?
      build_hidden_field_for_checkbox +
      template.label_tag(nil, class: boolean_label_class) {
        build_check_box_without_hidden_field(merged_input_options) +
        inline_label
      }
    else
      if include_hidden?
        build_check_box(unchecked_value, merged_input_options)
      else
        build_check_box_without_hidden_field(merged_input_options)
      end
    end
  end

  private

  def boolean_label_class
    options[:boolean_label_class] || SimpleForm.boolean_label_class
  end

  # Build a checkbox tag using default unchecked value. This allows us to
  # reuse the method for nested boolean style, but with no unchecked value,
  # which won't generate the hidden checkbox. This is the default functionality
  # in Rails > 3.2.1, and is backported in SimpleForm AV helpers.
  def build_check_box(unchecked_value, options)
    div = "<div class=\"w-11 h-6 bg-gray-200 rounded-full peer peer-focus:ring-4 peer-focus:ring-blue-300 dark:peer-focus:ring-blue-800 dark:bg-gray-700 peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all dark:border-gray-600 peer-checked:bg-blue-600 mr-2\"></div>"
    "#{@builder.check_box(attribute_name, options, checked_value, unchecked_value)}#{div}".html_safe
  end

  # Build a checkbox without generating the hidden field. See
  # #build_hidden_field_for_checkbox for more info.
  def build_check_box_without_hidden_field(options)
    build_check_box(nil, options)
  end

  # Create a hidden field for the current checkbox, so we can simulate Rails
  # functionality with hidden + checkbox, but under a nested context, where
  # we need the hidden field to be *outside* the label (otherwise it
  # generates invalid html - html5 only).
  def build_hidden_field_for_checkbox
    return "".html_safe if !include_hidden? || !unchecked_value
    options = { value: unchecked_value, id: nil, disabled: input_html_options[:disabled] }
    options[:name] = input_html_options[:name] if input_html_options.key?(:name)
    options[:form] = input_html_options[:form] if input_html_options.key?(:form)

    @builder.hidden_field(attribute_name, options)
  end

  def inline_label?
    nested_boolean_style? && options[:inline_label]
  end

  def inline_label
    inline_option = options[:inline_label]

    if inline_option
      label = inline_option == true ? label_text : html_escape(inline_option)
      " #{label}".html_safe
    end
  end

  # Booleans are not required by default because in most of the cases
  # it makes no sense marking them as required. The only exception is
  # Terms of Use usually presented at most sites sign up screen.
  def required_by_default?
    false
  end

  def include_hidden?
    options.fetch(:include_hidden, true)
  end

  def checked_value
    options.fetch(:checked_value, '1')
  end

  def unchecked_value
    options.fetch(:unchecked_value, '0')
  end
end
