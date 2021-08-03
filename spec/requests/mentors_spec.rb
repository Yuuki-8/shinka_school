require 'rails_helper'

RSpec.describe Mentor, type: :request do
  before do
    job = create(:job)
    pref = create(:pref)
    @mentor = build(:mentor, job: job, pref: pref)
  end

  describe 'バリデーション' do
  end
end