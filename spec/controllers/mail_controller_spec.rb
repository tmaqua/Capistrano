require 'rails_helper'

RSpec.describe MailController, type: :controller do

  # describe "GET #send_mail" do
  #   it "returns http success" do
  #     get :send_mail
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
