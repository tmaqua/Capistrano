require 'rails_helper'

RSpec.describe NotificationController, type: :controller do

  # describe "GET #send_push" do
  #   it "returns http success" do
  #     get :send_push
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #complete" do
    it "returns http success" do
      get :complete
      expect(response).to have_http_status(:success)
    end
  end

end
