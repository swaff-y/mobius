class PainScoresController < ApplicationController
  before_action :authenticate_user
  before_action :set_pain_score, only: %i[ show edit update destroy ]
  # skip_before_action :verify_authenticity_token

  # # GET /pain_scores or /pain_scores.json
  # def index
  #   @pain_scores = PainScore.all
  # end
  #
  # # GET /pain_scores/1 or /pain_scores/1.json
  # def show
  # end
  #
  # # GET /pain_scores/new
  # def new
  #   @pain_score = PainScore.new
  # end
  #
  # # GET /pain_scores/1/edit
  # def edit
  # end
  #
  # # POST /pain_scores or /pain_scores.json
  # def create
  #   @pain_score = PainScore.new(pain_score_params)
  #
  #   respond_to do |format|
  #     if @pain_score.save
  #       format.html { redirect_to @pain_score, notice: "Pain score was successfully created." }
  #       format.json { render :show, status: :created, location: @pain_score }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @pain_score.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /pain_scores/1 or /pain_scores/1.json
  # def update
  #   respond_to do |format|
  #     if @pain_score.update(pain_score_params)
  #       format.html { redirect_to @pain_score, notice: "Pain score was successfully updated." }
  #       format.json { render :show, status: :ok, location: @pain_score }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @pain_score.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /pain_scores/1 or /pain_scores/1.json
  # def destroy
  #   @pain_score.destroy
  #   respond_to do |format|
  #     format.html { redirect_to pain_scores_url, notice: "Pain score was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  def pain_scores_select_patient
    # params[:patient_id]
    pain_scores = Patient.find(params[:patient_id]).pain_scores.all
    render json: pain_scores
  end

  def create_pain_score
    custom_string = params[:custom_string].split(",");
    procedure_id = Patient.find(custom_string[0]).procedures.first.id

    puts "++++++++++++++++++++"
    puts custom_string[1]
    puts "++++++++++++++++++++"

    pain_score = PainScore.create(
      day: custom_string[1],
      score: params[:score],
      patient_id: custom_string[0],
      procedure_id: procedure_id
    )

    Patient.find(custom_string[0]).update(
      response_status: "Responded"
    )

    render json: pain_score
  end

  def update_pain_score
    pain_score = PainScore.where(patient_id: params[:patient_id], day: params[:day] )

    if pain_score != []
      Patient.find(params[:patient_id]).update(
        response_status: "No Response"
      )

      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end
  def update_pain_score_followup
    pain_score = PainScore.where(patient_id: params[:patient_id], day: params[:day] )

    if pain_score == []
      Patient.find(params[:patient_id]).update(
        response_status: "Follow up required"
      )

      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end
  def update_pain_score_responded
    pain_score = PainScore.where(patient_id: params[:patient_id], day: params[:day] )

    if pain_score != []
      Patient.find(params[:patient_id]).update(
        response_status: "Responded"
      )

      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end

  def pain_scores_one
    pain_score = PainScore.where(patient_id: params[:patient_id], day: params[:day] )

    if pain_score != []
      render json: {
        success: true
      }
      status = "true"
    else
      render json: {
        success: false
      }
      status = "false"
    end

    # puts "++++++++++++++++++++++++++++++="
    # puts status
    # puts pain_score
    # puts "++++++++++++++++++++++++++++++="
  end

  def pain_score_graph
    pain_scores  = PainScore.where(patient_id: params[:patient_id])

    pre_score_array = []
    pain_scores.each do |score|
        pre_score_array.push score.score
    end

    score_array = []
    increment = 0
    num = 0
    29.times do |day|
        if day == 0

            score_array.push pre_score_array[0]

        elsif day == 1
          score_array.push pre_score_array[1]
        elsif day == 2
          increment = ((pre_score_array[2].to_f - pre_score_array[1].to_f) / 3)
          num = increment + pre_score_array[1]
          score_array.push num
        elsif day == 3
          score_array.push pre_score_array[2]
        elsif day == 4
          increment = ((pre_score_array[3].to_f - pre_score_array[2].to_f) / 4)
          num = increment + pre_score_array[2]
          score_array.push num
        elsif day == 5
          num = num + increment
          score_array.push num
        elsif day == 6
          num = num + increment
          score_array.push num
        elsif day == 7
          score_array.push pre_score_array[3]
        elsif day == 8
          increment = ((pre_score_array[4].to_f - pre_score_array[3].to_f) / 7)
          num = increment + pre_score_array[3]
          score_array.push num
        elsif day == 9
          num = num + increment
          score_array.push num
        elsif day == 10
          num = num + increment
          score_array.push num
        elsif day == 11
          num = num + increment
          score_array.push num
        elsif day == 12
          num = num + increment
          score_array.push num
        elsif day == 13
          num = num + increment
          score_array.push num
        elsif day == 14
          score_array.push pre_score_array[4]
        elsif day == 15
          increment = ((pre_score_array[5].to_f - pre_score_array[4].to_f) / 14)
          num = increment + pre_score_array[4]
          score_array.push num
        elsif day == 16
          num = num + increment
          score_array.push num
        elsif day == 17
          num = num + increment
          score_array.push num
        elsif day == 18
          num = num + increment
          score_array.push num
        elsif day == 19
          num = num + increment
          score_array.push num
        elsif day == 20
          num = num + increment
          score_array.push num
        elsif day == 21
          num = num + increment
          score_array.push num
        elsif day == 22
          num = num + increment
          score_array.push num
        elsif day == 23
          num = num + increment
          score_array.push num
        elsif day == 24
          num = num + increment
          score_array.push num
        elsif day == 25
          num = num + increment
          score_array.push num
        elsif day == 26
          num = num + increment
          score_array.push num
        elsif day == 27
          num = num + increment
          score_array.push num
        elsif day == 28
          score_array.push pre_score_array[5]
        else
          score_array.push "t:"
        end

    end

    render json: {
      scores: score_array,
      array: pre_score_array
    }
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
