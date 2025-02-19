class DiscussionsController < ApplicationController
  before_action :set_project
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @discussions = @project.discussions.includes(:user) # ✅ Fix: Set `@discussions`
  end

  def show
    @messages = @discussion.messages.includes(:user)
  end

  def new
    @discussion = @project.discussions.build
  end

  def create
    @discussion = @project.discussions.build(discussion_params)
    @discussion.user = current_user

    if @discussion.save
      redirect_to project_discussion_path(@project, @discussion), notice: "Discussion created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @discussion.update(discussion_params)
      redirect_to project_discussion_path(@project, @discussion), notice: "Discussion updated successfully."
    else
      flash.now[:alert] = "Failed to update discussion."
      render :edit
    end
  end

  def destroy
    if @discussion.destroy
      redirect_to project_path(@project), notice: "Discussion deleted successfully."
    else
      redirect_to project_path(@project), alert: "Failed to delete the discussion."
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_discussion
    @discussion = @project.discussions.find(params[:id])
  end

  def authorize_admin!
    redirect_to @project, alert: "You are not authorized to perform this action." unless current_user.admin?
  end

  def discussion_params
    params.require(:discussion).permit(:title)
  end
end
