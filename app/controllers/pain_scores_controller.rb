class PainScoresController < ApplicationController
  before_action :set_pain_score, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /pain_scores or /pain_scores.json
  def index
    @pain_scores = PainScore.all
  end

  # GET /pain_scores/1 or /pain_scores/1.json
  def show
  end

  # GET /pain_scores/new
  def new
    @pain_score = PainScore.new
  end

  # GET /pain_scores/1/edit
  def edit
  end

  # POST /pain_scores or /pain_scores.json
  def create
    @pain_score = PainScore.new(pain_score_params)

    respond_to do |format|
      if @pain_score.save
        format.html { redirect_to @pain_score, notice: "Pain score was successfully created." }
        format.json { render :show, status: :created, location: @pain_score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pain_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pain_scores/1 or /pain_scores/1.json
  def update
    respond_to do |format|
      if @pain_score.update(pain_score_params)
        format.html { redirect_to @pain_score, notice: "Pain score was successfully updated." }
        format.json { render :show, status: :ok, location: @pain_score }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pain_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pain_scores/1 or /pain_scores/1.json
  def destroy
    @pain_score.destroy
    respond_to do |format|
      format.html { redirect_to pain_scores_url, notice: "Pain score was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def pain_scores_select_patient
    # params[:patient_id]
    pain_scores = Patient.find(params[:patient_id]).pain_scores.all
    render json: pain_scores
  end

  def create_pain_score
    custom_string = params[:custom_string].split(",");
    procedure_id = Patient.find(custom_string[0]).procedures.first.id

    pain_score = PainScore.create(
      day: custom_string[1],
      score: params[:score],
      patient_id: custom_string[0],
      procedure_id: procedure_id
    )
    render json: pain_score
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pain_score
      @pain_score = PainScore.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pain_score_params
      params.require(:pain_score).permit(:day, :patient, :procedure, :score)
    end
end
