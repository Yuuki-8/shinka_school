# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user, gender: "male") }
  let(:invalid_user_params) { attributes_for(:user, name: "", gender: "male") }

  describe "GET /users/home" do
    it "home画面の表示に成功すること" do
      get home_users_path
      expect(response).to(have_http_status(200))
    end
  end

  describe "POST #create" do
    context "パラメータが妥当な場合" do
      it "リクエストが成功すること" do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to(eq(302))
      end

      it "createが成功すること" do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to(change(User, :count).by(1))
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to(eq(200))
      end

      it "createが失敗すること" do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.to_not(change(User, :count))
      end
    end
  end

  describe "PUT #update" do
    context "パラメータが妥当な場合" do
      let(:user_params) { user.attributes }
      it "リクエストが成功すること" do
        put user_registration_path, params: { user: user_params }
        expect(response.status).to(eq(302))
      end

      it "updateが成功すること" do
        expect do
          put user_registration_path, params: { user: user_params }
        end.to(change(User, :count).by(1))
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        put user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to(eq(302))
      end

      it "updateが失敗すること" do
        expect do
          put user_registration_path, params: { user: invalid_user_params }
        end.to_not(change(User, :count))
      end
    end
  end
end
