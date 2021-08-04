require 'rails_helper'

RSpec.describe Club, type: :request do
  before do
    @user = create(:user)
  end

  let(:club) { create(:club) }
  let(:user_club) { create(:user_club, club: club, user: @user)}
  let(:create_params) do
    {
      club: {
        name: "test",
        description: description,
        image: nil,
      }
    }
  end
  let(:description) { "createテスト" }
  let(:update_params) do
    {
      club: {
        name: club.name,
        description: description,
        image: nil,
      }
    }
  end

  describe "GET /clubs/" do
    it 'index画面の表示に成功すること' do
      sign_in @user
      get clubs_path
      expect(response).to(have_http_status(200))
    end
  end

  describe "GET /clubs/:id" do
    it 'show画面の表示に成功すること' do
      sign_in @user
      get clubs_path(club)
      expect(response).to(have_http_status(200))
    end
  end

  describe "POST /clubs" do
    context "paramsが正常な値の場合" do
      it 'createに成功すること' do
        sign_in @user
        post clubs_path, params: create_params
        expect(response).to(have_http_status(302))
        expect(Club.count).to(eq(1))
        expect(flash[:notice]).to(eq("サークルを新規作成しました"))
      end
    end
    context "paramsが異常な値の場合" do
      let(:description) { nil }
      it 'createに失敗すること' do
        sign_in @user
        post clubs_path, params: create_params
        expect(response).to(have_http_status(302))
        expect(Club.count).to(eq(0))
        expect(flash[:notice]).to(eq("サークルを新規作成できませんでした"))
      end
    end
  end

  describe "PUT /club/:id" do
    context "paramsが正常な値の場合" do
      let(:description) { "updateテスト" }
      it 'updateに成功すること' do
        sign_in @user
        put club_path(club), params: update_params
        expect(response).to(have_http_status(302))
        expect(Club.last.description).to(eq(update_params[:club][:description]))
        expect(flash[:notice]).to(eq("サークル情報を更新しました"))
      end
    end
    context "paramsが異常な値の場合" do
      let(:description) { nil }
      it 'updateに失敗すること' do
        sign_in @user
        put club_path(club), params: update_params
        expect(response).to(have_http_status(302))
        expect(Club.last.description).not_to(eq(update_params[:club][:description]))
        expect(flash[:notice]).to(eq("サークル情報を更新できませんでした"))
      end
    end
  end

  describe "DELETE /club/:id" do
    it 'destroyに成功すること' do
      sign_in @user
      delete club_path(club)
      expect(response).to(have_http_status(302))
      expect(Club.find_by(id: club.id)).to(eq(nil))
    end
  end
end