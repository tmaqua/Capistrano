require 'rails_helper'

RSpec.describe MailController, type: :controller do

  describe "GET #send" do
    it "returns http success" do
      get :send
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #complete" do
    it "returns http success" do
      get :complete
      expect(response).to have_http_status(:success)
    end
  end

end
