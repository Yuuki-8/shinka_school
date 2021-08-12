class MentorScheduleSetting < ApplicationRecord
  belongs_to :mentor_setting

  enum weekday_code: %i( sun mon tue wed thu fri sat )
end
