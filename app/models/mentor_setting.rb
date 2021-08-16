# frozen_string_literal: true

class MentorSetting < ApplicationRecord
  belongs_to :mentor
  has_many :mentor_schedule_settings, dependent: :destroy

  accepts_nested_attributes_for :mentor_schedule_settings, allow_destroy: true
end
