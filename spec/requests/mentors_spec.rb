# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mentor, type: :request do
  let(:mentor) { create(:mentor) }
  let(:mentor_params) { attributes_for(:mentor, gender: "male") }
  let(:invalid_mentor_params) { attributes_for(:mentor, name: "", gender: "male") }

  describe "GET /mentors/" do
    it "index画面の表示に成功すること" do
      get mentors_path
      expect(response).to(have_http_status(200))
    end
  end

  describe "POST #create" do
    context "パラメータが妥当な場合" do
      it "リクエストが成功すること" do
        post mentor_registration_path, params: { mentor: mentor_params }
        expect(response.status).to(eq(302))
      end

      it "createが成功すること" do
        expect do
          post mentor_registration_path, params: { mentor: mentor_params }
        end.to(change(Mentor, :count).by(1))
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        post mentor_registration_path, params: { mentor: invalid_mentor_params }
        expect(response.status).to(eq(200))
      end

      it "createが失敗すること" do
        expect do
          post mentor_registration_path, params: { mentor: invalid_mentor_params }
        end.to_not(change(Mentor, :count))
      end
    end
  end

  describe "PUT #update" do
    context "パラメータが妥当な場合" do
      let(:mentor_params) { mentor.attributes }
      it "リクエストが成功すること" do
        put mentor_registration_path, params: { mentor: mentor_params }
        expect(response.status).to(eq(302))
      end

      it "updateが成功すること" do
        expect do
          put mentor_registration_path, params: { mentor: mentor_params }
        end.to(change(Mentor, :count).by(1))
      end
    end

    context "パラメータが不正な場合" do
      it "リクエストが成功すること" do
        put mentor_registration_path, params: { mentor: invalid_mentor_params }
        expect(response.status).to(eq(302))
      end

      it "updateが失敗すること" do
        expect do
          put mentor_registration_path, params: { mentor: invalid_mentor_params }
        end.to_not(change(Mentor, :count))
      end
    end
  end
end
