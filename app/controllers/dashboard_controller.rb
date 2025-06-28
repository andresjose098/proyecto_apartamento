# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # Aquí puedes cargar datos para el panel:
    # @usuario = current_user
  end
end
