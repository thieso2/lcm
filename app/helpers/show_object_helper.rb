module ShowObjectHelper
  
  def show_object(object, options={})
    unless attributes = options.fetch(:only, nil)
      attributes = object.attributes.keys
    end
    if except = options.fetch(:except, nil)
      attributes.except!(except)
    end
  
    
    capture do
    content_tag :div do
      content_tag(:h1) do
        object.class.to_s.humanize
      end +
      
      content_tag(:table, class: "table") do
        attributes.each do |attribute|
          concat(
            content_tag(:tr ) do
              concat (
                content_tag(:td) {t(attribute, scope: "#{SimpleForm.i18n_scope}.#{object.class}" ) } +
                content_tag(:td) {object.send(attribute.to_sym).to_s}
              )
            end
          )
        end
      end
    end
    end
  end
  
end