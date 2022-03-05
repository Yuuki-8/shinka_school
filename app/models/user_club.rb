# frozen_string_literal: true



class UserClub < ApplicationRecord

  belongs_to :user, optional: true

  belongs_to :club, optional: true

  # ↑userとclubにそれぞれ一つずつ紐づいていますよという意味

end