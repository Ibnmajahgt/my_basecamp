class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy destroy_attachment show_attachment]
  before_action :authenticate_user!  # Ensure the user is authenticated
  before_action :authorize_user!, only: %i[edit update destroy destroy_attachment]  # Restrict access to admins and project owner

  # GET /projects or /projects.json
  def index
    @projects = Project.includes(:user).all  # Eager load user details
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build  # Associate the project with the user
  end

  # POST /projects or /projects.json
  def create
    @project = current_user.projects.build(project_params)  # Associate project with user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully deleted." }
      format.json { head :no_content }
    end
  end

  # DELETE /projects/1/destroy_attachment/:attachment_id
  def destroy_attachment
    @attachment = @project.attachments.find(params[:attachment_id])

    if current_user.admin? || current_user == @project.user
      @attachment.purge # Purge the attachment from ActiveStorage
      redirect_to @project, notice: "Attachment was successfully removed."
    else
      redirect_to @project, alert: "You are not authorized to remove this attachment."
    end
  end

  # Show attachment page
  def show_attachment
    @attachment = @project.attachments.find(params[:attachment_id])
    # If needed, add any logic to show file previews here, but we'll assume the file is downloadable
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Restrict editing and deleting to only admins and the project owner
    def authorize_user!
      unless current_user.admin? || current_user == @project.user
        redirect_to projects_path, alert: "You are not authorized to perform this action."
      end
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, attachments: [])  # Allow attachments to be uploaded
    end
end
