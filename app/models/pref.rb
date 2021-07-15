class Pref < ApplicationRecord
  has_many :users
  has_many :mentors
end
