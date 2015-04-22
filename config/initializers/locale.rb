# tell the I18n library where to find your translations
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]

# set default locale to :de
I18n.default_locale = :de

I18n.exception_handler = lambda do |exception, locale, key, options|
  e = exception.respond_to?(:to_exception) ? exception.to_exception : exception
  debugger
  if e.is_a? I18n::MissingTranslationData
    stack = caller(4)
    log.info "#{locale}.#{key}"
    log.info stack.join("\n")
  end
  
end