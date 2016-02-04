class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reload_libs #, :if => defined? RELOAD_LIBS
  before_action :set_locale

  helper :show_object

  #def current_user
  #  puts "Pundit is looking for current_user"
  #  current_person
  #end

  private

  def configure_permitted_parameters
    puts "!!!!Checking params"
    devise_parameter_sanitizer.for(:sign_up) {|u|
      u.permit(:firstname, :lastname, :email, :password, :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) {|u|
      u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password)
    }
  end

  def reload_libs
    if Rails.env.development?
      RELOAD_LIBS.each do |lib|
        require_dependency lib
      end
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    puts "locale: #{I18n.locale}"
  end

end
