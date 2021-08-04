require 'rails_helper'

RSpec.describe Attendance, type: :request do
  before do
    @admin = create(:admin)
  end

  let(:attendance) { create(:attendance, admin: @admin) }
  let(:create_params) do
    {
      attendance: {
        admin_id: @admin.id,
        start_time: nil,
      }
    }
  end
  let(:update_params) do
    {
      attendance: {
        admin_id: @admin.id,
        start_time: attendance.start_time,
        end_time: '2021/8/1 19:00',
      }
    }
  end

  describe "GET /attendances/" do
    it 'index画面の表示に成功すること' do
      sign_in @admin
      get attendances_path
      expect(response).to(have_http_status(200))
    end
  end

  describe "GET /attendances/:id" do
    it 'show画面の表示に成功すること' do
      sign_in @admin
      get attendances_path(attendance)
      expect(response).to(have_http_status(200))
    end
  end

  describe "POST /attendances" do
    it 'createに成功すること' do
      sign_in @admin
      post attendances_path, params: create_params
      expect(response).to(have_http_status(200))
    end
  end

  describe "PUT /attendances/:id" do
    it 'updateに成功すること' do
      sign_in @admin
      post attendances_path(attendance), params: update_params
      expect(response).to(have_http_status(200))
    end
  end
end