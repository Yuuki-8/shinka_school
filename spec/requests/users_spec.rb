require 'rails_helper'

RSpec.describe User, type: :request do
  before do
    job = create(:job)
    pref = create(:pref)
    @user = build(:user, job: job, pref: pref)
  end

  describe 'バリデーション' do
  end
end