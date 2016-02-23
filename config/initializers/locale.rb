# tell the I18n library where to find your translations
# I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]

# set default locale to :de
I18n.default_locale = :de

I18n.exception_handler = lambda do |exception, locale, key, options|
  e = exception.respond_to?(:to_exception) ? exception.to_exception : exception
  if e.is_a? I18n::MissingTranslationData
    stack = caller(4)
    Rails.logger.info "MissingTranslation: #{locale}.#{key}"
    Rails.logger.info stack.first  # join("\n")
    puts  "MissingTranslation: #{locale}.#{key}"
  end
end
