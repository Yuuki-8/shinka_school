require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    job = create(:job)
    pref = create(:pref)
    @user = build(:user, job: job, pref: pref)
  end

  describe 'バリデーション' do
    it '全ての値が正しく設定されていれば @user.valid? が trueになること' do
      expect(@user.valid?).to(eq(true))
    end

    it 'nameが空だと @user.valid? が falseになること' do
      @user.name = ''
      expect(@user.valid?).to(eq(false))
    end

    it 'name_kanaが空だと @user.valid? が falseになること' do
      @user.name_kana = ''
      expect(@user.valid?).to(eq(false))
    end

    it 'emailが空だと @user.valid? が falseになること' do
      @user.email = ''
      expect(@user.valid?).to(eq(false))
    end

    it 'passwordが空だと @user.valid? が falseになること' do
      @user.password = ''
      expect(@user.valid?).to(eq(false))
    end

    it 'password_confirmationが空だと @user.valid? が falseになること' do
      @user.password_confirmation = ''
      expect(@user.valid?).to(eq(false))
    end

    it 'passwordとpassword_confirmationが合致しないと @user.valid? が falseになること' do
      @user.password = 'testpass'
      @user.password_confirmation = 'testpass1'
      expect(@user.valid?).to(eq(false))
    end
  end
end