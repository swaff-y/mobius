class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :set_user, only: %i[ show edit update destroy ]
  # skip_before_action :verify_authenticity_token

  # # GET /users or /users.json
  # def index
  #   @users = User.all
  # end
  #
  # # GET /users/1 or /users/1.json
  # def show
  # end
  #
  # # GET /users/new
  # def new
  #   @user = User.new
  # end
  #
  # # GET /users/1/edit
  # def edit
  # end
  #
  # # POST /users or /users.json
  # def create
  #   @user = User.new(user_params)
  #
  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: "User was successfully created." }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /users/1 or /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: "User was successfully updated." }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /users/1 or /users/1.json
  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end


    def team_members_all
      team_members = User.all.where(status: "Active", role: "Contributor")
      render json: team_members, include: ['clinics']
    end
    def team_members_all_complete
      team_members = User.all.where(status: "Active")
      render json: team_members, include: ['clinics']
    end

    def team_members_select_clinic
      team_members = Clinic.find(params[:clinic_id]).users.all.where(status: "Active", role: "Contributor")
      render json: team_members, include: ['clinics']
    end

    def team_member_one
      # params[:team_member_id]
      team_member = User.where(status: "Active").find(params[:team_member_id])
      render json: team_member, include: ['clinics']
    end
    # def team_member_select_clinic
    #   params[:clinic_id]
    # end

    def create_team_member
      clinics = params[:clinics].split(", ")

      team_member = User.create(
        email: params[:email],
        first_name: params[:first_name],
        last_name: params[:last_name],
        user: params[:user],
        status: "Active",
        role: params[:role]
      )

      clinics.each do |clinic|
        Clinic.find(clinic).users << team_member
      end

      render json: team_member, include: ['clinics']
    end

    def edit_team_member
      team_member = User.find(params[:team_member_id])
      clinics = params[:clinics].split(", ")

      team_member.update(
        email: params[:email],
        first_name: params[:first_name],
        last_name: params[:last_name],
        role: params[:role]
      )

      all_clinics = team_member.clinics.all

      all_clinics.each do |clinic|
        if clinic
          team_member.clinics.delete clinic
        end
      end

      clinics.each do |clinic|
        Clinic.find(clinic).users << team_member
      end

      render json: team_member, include: ['clinics']
    end

    def edit_team_member_no_clinic
      team_member = User.find(params[:team_member_id])

      team_member.update(
        email: params[:email],
        first_name: params[:first_name],
        last_name: params[:last_name]
      )

      render json: team_member, include: ['clinics']
    end

    def delete_team_member
      team_member = User.find(params[:team_member_id])

      team_member.update(
        status:"Inactive"
      )

      render json: team_member
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :user, :status, :role, :password_digest)
    end
end
