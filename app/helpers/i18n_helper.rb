module I18nHelper
  def translate(key,options={})
    super(key, options.merge(raise: true))
  rescue I18n::MissingTranslationData => e
    Rails.logger.info e.inspect
  end
  alias :t :translate  
end