require 'net/http'
require 'json'

class CheckInsController < ApplicationController
  before_action :set_check_in, only: %i[show]
  before_action :set_questionnaire, only: %i[new create]

  def new
    @check_in = CheckIn.new
    @questions = @questionnaire.questions.order(:order).limit(2)
  end

  def create
    @check_in = CheckIn.new(check_in_params)
    @questions = @questionnaire.questions.order(:order).limit(2)

    first_name = request_params[:first_name]
    last_name = request_params[:last_name]

    user_data = { id: 1 }.deep_stringify_keys
    if user_data
      @check_in.patient_id = user_data['id']
    else
      flash[:error] = 'User not found'
      render :new and return
    end
    if @check_in.save
      save_check_in_results(check_in_result_params)
      questions_response_list = check_in_result_params[:questions]&.values || []
      additional_screening = questions_response_list.any? { |params| high_score?(params[:response_option_num]) }

      if additional_screening
        redirect_to @check_in, notice: 'Additional screening should be completed.'
      else
        redirect_to @check_in, notice: 'Additional screening is not needed.'
      end
    else
      render :new
    end
  end


  def show
    @severity = CheckInResult.determine_severity(@check_in_result.total_score)
    @user = fetch_user
  end

  def update
    CheckIn.find(params[:id])
    redirect_to new_check_in_path
  end

  private

  def set_check_in
    @check_in = CheckIn.find(params[:id])
    @check_in_result = CheckInResult.find_by(check_in: @check_in)
  end

  def set_questionnaire
    @questionnaire = Questionnaire.find_by(name: 'PHQ-9')
  end

  def high_score?(score)
    score.to_i > 1
  end

  def check_in_params
    params.require(:check_in).permit(:date)
  end

  def request_params
    params.permit(:first_name, :last_name)
  end

  def check_in_result_params
    params.require(:check_in_result).permit(questions: %i[id statement response_option_num])
  end

  def fetch_user(_first_name=nil, _last_name=nil)
    uri = URI('https://dummyjson.com/users/1')
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)

  rescue StandardError => e
    Rails.logger.error("Failed to fetch user ID: #{e.message}")
  end

  def save_check_in_results(results)
    check_in_result = find_or_initialize_check_in_result
    check_in_result.response = map_results_to_responses(results)
    check_in_result.save!
  end

  def find_or_initialize_check_in_result
    CheckInResult.find_or_initialize_by(
      check_in: @check_in,
      questionnaire: @questionnaire
    )
  end

  def map_results_to_responses(result_params)
    questions_response_list = result_params[:questions]&.values || []
    questions_response_list.map do |question_response|
      {
        q_id: question_response[:id],
        statement: question_response[:statement],
        response_option_num: question_response[:response_option_num]
      }
    end
  end
end
