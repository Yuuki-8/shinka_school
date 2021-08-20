# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin, type: :request do
  let(:admin) { create(:admin) }
  let(:admin_params) { attributes_for(:admin, gender: "male") }
  let(:invalid_admin_params) { attributes_for(:admin, name: "", gender: "male") }

  describe "GET /admins/home" do
    it "home画面の表示に成功すること" do
      get home_admins_path
      expect(response).to(have_http_status(200))
    end
  end

  describe "POST #create" do
    context "パラメータが妥当な場合" do
      it "リクエストが成功すること" do
        post admin_registration_path, params: { admin: admin_params }
        expect(response.status).to(eq(302))
      end

      it "createが成功すること" do
        expect do
          post admin_registration_path, params: { admin: admin_params }
        end.to(change(Admin, :count).by(1))
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        post admin_registration_path, params: { admin: invalid_admin_params }
        expect(response.status).to(eq(200))
      end

      it "createが失敗すること" do
        expect do
          post admin_registration_path, params: { admin: invalid_admin_params }
        end.to_not(change(Admin, :count))
      end
    end
  end

  describe "PUT #update" do
    context "パラメータが妥当な場合" do
      let(:admin_params) { admin.attributes }
      it "リクエストが成功すること" do
        put admin_registration_path, params: { admin: admin_params }
        expect(response.status).to(eq(302))
      end

      it "updateが成功すること" do
        expect do
          put admin_registration_path, params: { admin: admin_params }
        end.to(change(Admin, :count).by(1))
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        put admin_registration_path, params: { admin: invalid_admin_params }
        expect(response.status).to(eq(302))
      end

      it "updateが失敗すること" do
        expect do
          put admin_registration_path, params: { admin: invalid_admin_params }
        end.to_not(change(Admin, :count))
      end
    end
  end
end
