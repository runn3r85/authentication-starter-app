require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do

  describe "GET#new" do
    it "returns http success" do
      get :new, {}
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new, {}
      expect(response).to render_template('new')
    end
  end

  describe "POST create" do
    context "with correct credentials" do
      let!(:user) { create(:user) }

      it "redirects to the dashboard" do
        post :create, email: user.email, password: "math1234"
        expect(response).to be_redirect
        expect(response).to redirect_to(dashboard_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with({ email: user.email }).and_return(user)
        post :create, email: user.email, password: "math1234"
      end

      it "authenticates the user" do
        allow(User).to receive(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: user.email, password: "math1234"
      end

      it "sets session[:user_id]" do
        post :create, email: user.email, password: "math1234"
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets flash[:success]" do
        post :create, email: user.email, password: "math1234"
        expect(flash[:success]).to eq("Thank you for signing in!")
      end
    end

    shared_examples_for "denied login" do
      it "renders the new template" do
        post :create, email: email, password: password
        expect(response).to render_template('new')
      end

       it "sets flash[:error]" do
        post :create, email: email, password: password
        expect(flash[:error]).to eq("There was a problem signing in. Please check your email and password.")
      end
    end

    context "with blank credentials" do
      let(:email) {""}
      let(:password) {""}
      it_behaves_like "denied login"
    end

    context "with incorrect password" do
      let!(:user) { create(:user) }
      let(:email) { user.email }
      let(:password) { "incorrect" }
      it_behaves_like "denied login"
    end

    context "with no e-mail in existence" do
      let(:email) { "none@found.com" }
      let(:password) { "incorrect" }
      it_behaves_like "denied login"
    end
  end

end
