require 'rails_helper'

RSpec.describe CheckInsController, type: :controller do

  let(:check_in) { create(:check_in, patient_id: 1, date: Date.current) }
  let!(:questionnaire) { create(:questionnaire, name: "PHQ-9") }
  let!(:question1) {create(:question, question_statement: "Question statement.") }
  let!(:question2) {create(:question, question_statement: "Question statement.") }
  let!(:questionnaire_question) do
    create(:questionnaire_question, questionnaire_id: questionnaire.id, question_id: question1.id)
  end
  let(:check_in_result) do
    create(:check_in_result, check_in_id: check_in.id, questionnaire_id: questionnaire.id)
  end

  describe "routing" do
    it { should route(:get, "/check_ins/new").to(action: :new) }
    it { should route(:post, "/check_ins").to(action: :create) }
    it { should route(:get, "/check_ins/1").to(action: :show, id: 1) }
    it { should route(:put, "/check_ins/1").to(action: :update, id: 1) }
  end

  describe "GET #new" do
    it "renders the view" do
      get :new

      expect(response).to render_template(:new)
      expect(response).to render_with_layout(:application)
    end
  end

  describe "POST #create" do
    it "creates a new check_in" do
      params = {
        check_in: { date: '2024-03-04' },
        first_name: "John",
        last_name: "Doe",
        check_in_result: {
          questions: {
            "1" => { id: question1.id, statement: question1.question_statement, response_option_num: '0' },
            "2" => { id: question2.id, statement: question2.question_statement, response_option_num: '2' }
          }
        }
      }
      stub_request(:get, "https://dummyjson.com/users/1")
        .with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host'=>'dummyjson.com',
            'User-Agent'=>'Ruby'
          })

      post :create, params: params

      expect(response).to be_successful
      expect(response).to have_http_status(:created)
    end

    it "redirects to the check_in show page" do
      check_in = create(:check_in, id: 1)
      allow(CheckIn).to receive(:create).and_return(check_in)

      post :create

      expect(CheckIn).to have_received(:create)
      expect(response).to redirect_to check_in_path(1)
    end
  end

  describe "GET #show" do
    it "finds the check_in" do
      check_in = create(:check_in, patient_id: 1, date: Date.current)
      questionnaire = create(:questionnaire, name: "Test")
      question = create(:question, question_statement: "Question statement.")
      questionnaire_question = create(:questionnaire_question, questionnaire_id: questionnaire.id, question_id: question.id)
      check_in_result = create(:check_in_result, check_in_id: check_in.id, questionnaire_id: questionnaire.id)

      allow(CheckIn).to receive(:find).with("1").and_return(check_in)

      get :show, params: { id: 1 }

      expect(CheckIn).to have_received(:find).with("1")
    end

    it "shows the current check in" do
      check_in = create(:check_in, id: 1, date: Date.current)
      allow(CheckIn).to receive(:create).and_return(check_in)

      get :show, params: { id: 1 }

      expect(response).to render_template(:show)
      expect(response).to render_with_layout(:application)
    end
  end

  describe "PUT #update" do
    it "finds the check_in" do
      check_in = create(:check_in, id: 1)
      allow(CheckIn).to receive(:find).with("1").and_return(check_in)

      put :update, params: { id: 1 }

      expect(CheckIn).to have_received(:find).with("1")
    end

    it "redirects to the new check_in page" do
      check_in = create(:check_in, id: 1)
      allow(CheckIn).to receive(:find).with("1").and_return(check_in)

      put :update, params: { id: 1 }

      expect(response).to redirect_to new_check_in_path
    end
  end
end
