require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'バリデーション' do
    it '全ての値が正しく設定されていれば @user.valid? が trueになること' do
      expect(@user.valid?).to(eq(true))
    end

    describe "name" do
      it 'nameが空だと @user.valid? が falseになること' do
        @user.name = ''
        expect(@user.valid?).to(eq(false))
      end
    end

    describe "name_kana" do
      it 'name_kanaが空だと @user.valid? が falseになること' do
        @user.name_kana = ''
        expect(@user.valid?).to(eq(false))
      end
      it 'name_kanaのvalueがひらがなカタカナ以外を服含むと @user.valid? が falseになること' do
        @user.name_kana = 'なまえ1'
        expect(@user.valid?).to(eq(false))
      end
      it 'name_kanaのvalueがひらがなカタカナのみであれば @user.valid? が trueになること' do
        @user.name_kana = 'なまえナマエ'
        expect(@user.valid?).to(eq(true))
      end
    end

    describe "email" do
      it 'emailが空だと @user.valid? が falseになること' do
        @user.email = ''
        expect(@user.valid?).to(eq(false))
      end
      it 'emailがアドレスの形を保っていないと @user.valid? が falseになること' do
        @user.email = 'test'
        expect(@user.valid?).to(eq(false))
      end
      it 'emailがアドレスの形を保っていると @user.valid? が trueになること' do
        @user.email = 'test@test.com'
        expect(@user.valid?).to(eq(true))
      end
    end

    describe "phone" do
      it 'phoneのvalueが9桁以下だと @user.valid? がfalseになること' do
        @user.phone = '12345678'
        expect(@user.valid?).to(eq(false))
      end
      it 'phoneのvalueが12桁以上だと @user.valid? がfalseになること' do
        @user.phone = '123456789012'
        expect(@user.valid?).to(eq(false))
      end
      it 'phoneのvalueが9~11桁の範囲内だと @user.valid? がtrueになること' do
        @user.phone = '1234567890'
        expect(@user.valid?).to(eq(true))
      end
    end

    describe "password" do
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
end