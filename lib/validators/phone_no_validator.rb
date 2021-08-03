class PhoneNoValidator < ActiveModel::EachValidator
  CODE_REGEX = /^[0-9]{9,11}$/.freeze
  CODE_MESSEG = '半角数字のみ ハイフン不要(11桁以下)'.freeze

  def validate_each(record, attribute, value)
    return if value.blank?
    return if value.match(CODE_REGEX).present?

    record.errors.add(attribute, "#{record.class.human_attribute_name(attribute)}の書式が不適切です")
  end
end
