class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy assign_admin remove_admin]
  before_action :authorize_admin, only: [:index, :new, :create, :assign_admin, :remove_admin]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
  
    respond_to do |format|
      if @user.save
        # Assign admin role if checkbox is checked
        @user.add_role(:admin) if params[:user][:admin] == "1"
        format.html { redirect_to users_path, notice: "User created successfully." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def assign_admin
    if current_user == @user
      redirect_to users_path, alert: "You cannot assign yourself as Admin."
    elsif !@user.has_role?(:admin)
      @user.add_role(:admin)
      redirect_to users_path, notice: "Admin role assigned successfully."
    else
      redirect_to users_path, alert: "User is already an Admin."
    end
  end

  def remove_admin
    if current_user == @user
      redirect_to users_path, alert: "You cannot remove yourself as Admin."
    elsif @user.has_role?(:admin)
      @user.remove_role(:admin)
      redirect_to users_path, notice: "Admin role removed successfully."
    else
      redirect_to users_path, alert: "User is not an Admin."
    end
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Access denied!" unless current_user.has_role?(:admin)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to users_path, alert: "User not found" unless @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end
end
