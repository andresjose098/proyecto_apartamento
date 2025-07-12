# app/controllers/documents_controller.rb
class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: %i[show destroy]

  # Solo estas tres acciones requieren ser admin:
  before_action :admin_only, only: %i[new create destroy]

  # GET /documents
  def index
    @documents = Document.order(created_at: :desc)
  end

  # GET /documents/:id
  def show
    # Devuelve el archivo como descarga directa
    redirect_to rails_blob_path(@document.file, disposition: :attachment)
  end

  # GET /documents/new (solo admin)
  def new
    @document = Document.new
  end

  # POST /documents (solo admin)
  def create
    @document = current_user.documents.build(document_params)
    if @document.save
      redirect_to documents_path, notice: "Documento subido."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /documents/:id (solo admin)
   def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_path, notice: "Documento eliminado." }
      format.turbo_stream            # si usas Turbo para quitar la fila
    end
  end

  private

  def document_params
    params.require(:document).permit(:title, :file)
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def admin_only
    redirect_to documents_path, alert: "Acceso restringido." unless current_user.admin?
  end
end
