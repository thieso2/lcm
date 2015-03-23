module SimpleFormHelper
  
  def vertical_form(resource, options = {}, &block)
    options[:html] = { class: 'form-vertical'}
    options[:wrapper] = :vertical_form
    options[:wrapper_mappings] = {
      check_boxes: :vertical_radio_and_checkboxes,
      radio_buttons: :vertical_radio_and_checkboxes,
      file: :vertical_file_input,
      boolean: :vertical_boolean
    }
    simple_form_for(resource, options, &block)
  end

  def horizontal_form(resource, options = {}, &block)
    if options.delete(:readonly)
      options[:html] = { class: 'form-horizontal readonly'}
    else
      options[:html] = { class: 'form-horizontal'}
    end
    
    options[:wrapper] = :horizontal_form
    options[:wrapper_mappings] = {
      check_boxes: :horizontal_radio_and_checkboxes,
      radio_buttons: :horizontal_radio_and_checkboxes,
      file: :horizontal_file_input,
      boolean: :horizontal_boolean
    }
    simple_form_for(resource, options, &block)
  end
  
  def inline_form(resource, options = {}, &block)
    options[:html] = { class: 'form-inline'}
    options[:wrapper] = :inline_form
    options[:wrapper_mappings] = {
      check_boxes: :inline_radio_and_checkboxes,
      radio_buttons: :inline_radio_and_checkboxes,
      file: :inline_file_input,
      boolean: :inline_boolean
    }
    simple_form_for(resource, options, &block)
  end
  
end