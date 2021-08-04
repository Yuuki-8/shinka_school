require 'rails_helper'

RSpec.describe Event, type: :request do
  before do
    @user = create(:user)
  end

  let(:event) { create(:event) }
  let(:user_event) { create(:user_event, event: event, user: @user)}
  let(:create_params) do
    {
      event: {
        title: title,
        start_date: "2021/8/1 10:00",
        end_date: "2021/8/1 12:00",
        deadline_date: "2021/8/1 08:00",
        place: "オフィス",
      }
    }
  end
  let(:title) { "createテスト" }
  let(:update_params) do
    {
      event: {
        title: title,
        start_date: "2021/8/1 10:00",
        end_date: "2021/8/1 12:00",
        deadline_date: "2021/8/1 08:00",
        place: "オフィス",
      }
    }
  end

  describe "GET /events/" do
    it 'index画面の表示に成功すること' do
      sign_in @user
      get events_path
      expect(response).to(have_http_status(200))
    end
  end

  describe "GET /events/:id" do
    it 'show画面の表示に成功すること' do
      sign_in @user
      get events_path(event)
      expect(response).to(have_http_status(200))
    end
  end

  describe "POST /events" do
    context "paramsが正常な値の場合" do
      it 'createに成功すること' do
        sign_in @user
        post events_path, params: create_params
        expect(response).to(have_http_status(302))
        expect(Event.count).to(eq(1))
        expect(flash[:notice]).to(eq("イベントを新規作成しました"))
      end
    end
    context "paramsが異常な値の場合" do
      let(:title) { nil }
      it 'createに失敗すること' do
        sign_in @user
        post events_path, params: create_params
        expect(response).to(have_http_status(302))
        expect(Event.count).to(eq(0))
        expect(flash[:notice]).to(eq("イベントを新規作成できませんでした"))
      end
    end
  end

  describe "PUT /event/:id" do
    context "paramsが正常な値の場合" do
      let(:title) { "updateテスト" }
      it 'updateに成功すること' do
        sign_in @user
        put event_path(event), params: update_params
        expect(response).to(have_http_status(302))
        expect(Event.last.title).to(eq(update_params[:event][:title]))
        expect(flash[:notice]).to(eq("イベント情報を更新しました"))
      end
    end
    context "paramsが異常な値の場合" do
      let(:title) { nil }
      it 'updateに失敗すること' do
        sign_in @user
        put event_path(event), params: update_params
        expect(response).to(have_http_status(302))
        expect(Event.last.title).not_to(eq(update_params[:event][:title]))
        expect(flash[:notice]).to(eq("イベント情報を更新できませんでした"))
      end
    end
  end

  describe "DELETE /event/:id" do
    it 'destroyに成功すること' do
      sign_in @user
      delete event_path(event)
      expect(response).to(have_http_status(302))
      expect(Event.find_by(id: event.id)).to(eq(nil))
    end
  end
end