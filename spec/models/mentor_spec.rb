require 'rails_helper'

RSpec.describe Mentor, type: :model do
  before do
    job = create(:job)
    pref = create(:pref)
    @mentor = build(:mentor, job: job, pref: pref)
  end

  describe 'バリデーション' do
    it '全ての値が正しく設定されていれば @mentor.valid? が trueになること' do
      expect(@mentor.valid?).to(eq(true))
    end

    it 'nameが空だと @mentor.valid? が falseになること' do
      @mentor.name = ''
      expect(@mentor.valid?).to(eq(false))
    end

    it 'name_kanaが空だと @mentor.valid? が falseになること' do
      @mentor.name_kana = ''
      expect(@mentor.valid?).to(eq(false))
    end

    it 'emailが空だと @mentor.valid? が falseになること' do
      @mentor.email = ''
      expect(@mentor.valid?).to(eq(false))
    end

    it 'passwordが空だと @mentor.valid? が falseになること' do
      @mentor.password = ''
      expect(@mentor.valid?).to(eq(false))
    end

    it 'password_confirmationが空だと @mentor.valid? が falseになること' do
      @mentor.password_confirmation = ''
      expect(@mentor.valid?).to(eq(false))
    end

    it 'passwordとpassword_confirmationが合致しないと @mentor.valid? が falseになること' do
      @mentor.password = 'testpass'
      @mentor.password_confirmation = 'testpass1'
      expect(@mentor.valid?).to(eq(false))
    end
  end
end