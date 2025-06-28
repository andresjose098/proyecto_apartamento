# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Esto se ejecuta después de que Devise autentique al usuario
  def after_sign_in_path_for(resource)
    dashboard_path
  end
end
