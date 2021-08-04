require 'rails_helper'

RSpec.describe Job, type: :model do
  before do
    @job = build(:job)
    create(:user, job: @job)
    create(:mentor, job: @job)
  end

  describe 'バリデーション' do
    it '全ての値が正しく設定されていれば @job.valid? が trueになること' do
      expect(@job.valid?).to(eq(true))
    end

    describe "name" do
      it 'nameが空だと @job.valid? が falseになること' do
        @job.name = ''
        expect(@job.valid?).to(eq(false))
      end
    end
  end

  describe 'アソシエーション' do
    it "紐づくuserが取得できていること" do
      expect(@job.users.present?).to(eq(true))
    end
    it "紐づくmentorが取得できていること" do
      expect(@job.mentors.present?).to(eq(true))
    end
  end
end