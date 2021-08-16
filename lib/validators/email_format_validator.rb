# frozen_string_literal: true

class EmailFormatValidator < ActiveModel::EachValidator
  CODE_REGEX = /\A.+@.+\..+\z/.freeze
  CODE_MESSEG = "admin@example.com"

  def validate_each(record, attribute, value)
    return if value.blank?
    value.split(",").each do |v|
      record.errors.add(attribute, "invalid email") unless v.match(CODE_REGEX).present?
    end
  end
end
