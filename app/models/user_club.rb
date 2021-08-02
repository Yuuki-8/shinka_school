class UserClub < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :club, optional: true
end