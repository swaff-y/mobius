class ProceduresController < ApplicationController
  before_action :authenticate_user
  before_action :set_procedure, only: %i[ show edit update destroy ]

  # # GET /procedures or /procedures.json
  # def index
  #   @procedures = Procedure.all
  # end
  #
  # # GET /procedures/1 or /procedures/1.json
  # def show
  # end
  #
  # # GET /procedures/new
  # def new
  #   @procedure = Procedure.new
  # end
  #
  # # GET /procedures/1/edit
  # def edit
  # end
  #
  # # POST /procedures or /procedures.json
  # def create
  #   @procedure = Procedure.new(procedure_params)
  #
  #   respond_to do |format|
  #     if @procedure.save
  #       format.html { redirect_to @procedure, notice: "Procedure was successfully created." }
  #       format.json { render :show, status: :created, location: @procedure }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @procedure.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /procedures/1 or /procedures/1.json
  # def update
  #   respond_to do |format|
  #     if @procedure.update(procedure_params)
  #       format.html { redirect_to @procedure, notice: "Procedure was successfully updated." }
  #       format.json { render :show, status: :ok, location: @procedure }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @procedure.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /procedures/1 or /procedures/1.json
  # def destroy
  #   @procedure.destroy
  #   respond_to do |format|
  #     format.html { redirect_to procedures_url, notice: "Procedure was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  def procedure_one
    # params[:procedure_id]
    procedure = Procedure.find(params[:procedure_id])
    render json: procedure
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def procedure_params
      params.require(:procedure).permit(:description, :name, :procedure_ID)
    end
end
