require 'rails_helper'

RSpec.describe Admin, type: :request do
  before do
  end

  describe "GET /admins/" do
    it 'index画面の表示に成功すること' do
      get admins_path
      expect(response).to(have_http_status(200))
    end
  end
end