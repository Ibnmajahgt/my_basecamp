class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_and_discussion
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def show
    # This will render show.html.erb for the message
  end

  def new
    @message = @discussion.messages.build
  end

  def create
    @message = @discussion.messages.build(message_params)
    @message.user = current_user
  
    if @message.save
      if current_user.admin?
        redirect_to project_discussion_path(@project, @discussion), notice: "Message created successfully."
      else
        redirect_to project_path(@project), notice: "Your reply has been added."
      end
    else
      flash.now[:alert] = "Failed to add reply."
      render :new
    end
  end
  
  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to project_discussion_path(@project, @discussion), notice: 'Message updated successfully.'
    else
      flash.now[:alert] = "Failed to update message."
      render :edit
    end
  end

  def destroy
    if @message.destroy
      redirect_to project_discussion_path(@project, @discussion), notice: 'Message deleted successfully.'
    else
      redirect_to project_discussion_path(@project, @discussion), alert: "Failed to delete message."
    end
  rescue => e
    redirect_to project_discussion_path(@project, @discussion), alert: "An error occurred: #{e.message}"
  end

  private

  def set_project_and_discussion
    @project = Project.find(params[:project_id])
    @discussion = @project.discussions.find(params[:discussion_id])
  end

  def set_message
    @message = @discussion.messages.find(params[:id])
  end

  def authorize_user!
    return if current_user.admin?  # Admins can edit/delete any message
    return if current_user == @message.user  # Users can edit/delete their own messages

    redirect_to project_discussion_path(@project, @discussion), alert: "You are not authorized to perform this action."
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
