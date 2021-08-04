require 'rails_helper'

RSpec.describe Mentor, type: :model do
  before do
    @mentor = build(:mentor)
  end

  describe 'バリデーション' do
    it '全ての値が正しく設定されていれば @mentor.valid? が trueになること' do
      expect(@mentor.valid?).to(eq(true))
    end

    describe "name" do
      it 'nameが空だと @mentor.valid? が falseになること' do
        @mentor.name = ''
        expect(@mentor.valid?).to(eq(false))
      end
    end

    describe "name_kana" do
      it 'name_kanaが空だと @mentor.valid? が falseになること' do
        @mentor.name_kana = ''
        expect(@mentor.valid?).to(eq(false))
      end
      it 'name_kanaのvalueがひらがなカタカナ以外を服含むと @mentor.valid? が falseになること' do
        @mentor.name_kana = 'なまえ1'
        expect(@mentor.valid?).to(eq(false))
      end
      it 'name_kanaのvalueがひらがなカタカナのみであれば @mentor.valid? が trueになること' do
        @mentor.name_kana = 'なまえナマエ'
        expect(@mentor.valid?).to(eq(true))
      end
    end

    describe "email" do
      it 'emailが空だと @mentor.valid? が falseになること' do
        @mentor.email = ''
        expect(@mentor.valid?).to(eq(false))
      end
      it 'emailがアドレスの形を保っていないと @mentor.valid? が falseになること' do
        @mentor.email = 'test'
        expect(@mentor.valid?).to(eq(false))
      end
      it 'emailがアドレスの形を保っていると @mentor.valid? が trueになること' do
        @mentor.email = 'test@test.com'
        expect(@mentor.valid?).to(eq(true))
      end
    end

    describe "phone" do
      it 'phoneのvalueが9桁以下だと @mentor.valid? がfalseになること' do
        @mentor.phone = '12345678'
        expect(@mentor.valid?).to(eq(false))
      end
      it 'phoneのvalueが12桁以上だと @mentor.valid? がfalseになること' do
        @mentor.phone = '123456789012'
        expect(@mentor.valid?).to(eq(false))
      end
      it 'phoneのvalueが9~11桁の範囲内だと @mentor.valid? がtrueになること' do
        @mentor.phone = '1234567890'
        expect(@mentor.valid?).to(eq(true))
      end
    end

    describe "password" do
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
end