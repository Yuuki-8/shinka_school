# frozen_string_literal: true



class UserEvent < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :event, optional: true

end