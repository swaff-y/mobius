class TeamMembersController < ApplicationController
  before_action :set_team_member, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /team_members or /team_members.json
  def index
    @team_members = TeamMember.all
  end

  # GET /team_members/1 or /team_members/1.json
  def show
  end

  # GET /team_members/new
  def new
    @team_member = TeamMember.new
  end

  # GET /team_members/1/edit
  def edit
  end

  # POST /team_members or /team_members.json
  def create
    @team_member = TeamMember.new(team_member_params)

    respond_to do |format|
      if @team_member.save
        format.html { redirect_to @team_member, notice: "Team member was successfully created." }
        format.json { render :show, status: :created, location: @team_member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_members/1 or /team_members/1.json
  def update
    respond_to do |format|
      if @team_member.update(team_member_params)
        format.html { redirect_to @team_member, notice: "Team member was successfully updated." }
        format.json { render :show, status: :ok, location: @team_member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_members/1 or /team_members/1.json
  def destroy
    @team_member.destroy
    respond_to do |format|
      format.html { redirect_to team_members_url, notice: "Team member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def team_members_all
    team_members = TeamMember.all.where(status: "Active", role: "Contributor")
    render json: team_members, include: ['clinics']
  end
  def team_members_all_complete
    team_members = TeamMember.all.where(status: "Active")
    render json: team_members, include: ['clinics']
  end

  def team_members_select_clinic
    team_members = Clinic.find(params[:clinic_id]).team_members.all.where(status: "Active", role: "Contributor")
    render json: team_members, include: ['clinics']
  end

  def team_member_one
    # params[:team_member_id]
    team_member = TeamMember.where(status: "Active").find(params[:team_member_id])
    render json: team_member, include: ['clinics']
  end
  # def team_member_select_clinic
  #   params[:clinic_id]
  # end

  def create_team_member
    clinics = params[:clinics].split(", ")

    team_member = TeamMember.create(
      email: params[:email],
      first_name: params[:first_name],
      last_name: params[:last_name],
      user: params[:user],
      status: "Active",
      role: params[:role]
    )

    clinics.each do |clinic|
      Clinic.find(clinic).team_members << team_member
    end

    render json: team_member, include: ['clinics']
  end

  def edit_team_member
    team_member = TeamMember.find(params[:team_member_id])
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
      Clinic.find(clinic).team_members << team_member
    end

    render json: team_member, include: ['clinics']
  end

  def edit_team_member_no_clinic
    team_member = TeamMember.find(params[:team_member_id])

    team_member.update(
      email: params[:email],
      first_name: params[:first_name],
      last_name: params[:last_name]
    )

    render json: team_member, include: ['clinics']
  end

  def delete_team_member
    team_member = TeamMember.find(params[:team_member_id])

    team_member.update(
      status:"Inactive"
    )

    render json: team_member
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_member
      @team_member = TeamMember.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_member_params
      params.require(:team_member).permit(:email, :first_name, :last_name, :user)
    end
end
