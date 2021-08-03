class NameKanaValidator < ActiveModel::EachValidator
  CODE_REGEX = /\A[ぁ-んァ-ヴ゛゜ー－( |　)+]*\z/.freeze

  def validate_each(record, attribute, value)
    return if value.blank?
    return if value.match(CODE_REGEX).present?

    record.errors.add(attribute, "#{record.class.human_attribute_name(attribute)}の書式が不適切です")
  end
end
