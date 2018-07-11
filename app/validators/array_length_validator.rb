class ArrayLengthValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless validate_options(options, value)
    array_size = value.size

    minimum = options[:minimum] || array_size
    maximum = options[:maximum] || array_size

    error = get_error(array_size, minimum, maximum)
    return if error.blank?

    record.errors[attribute] << I18n.t("errors.messages.#{error}.other")
  end

  protected

  def validate_options(options, value)
    return false unless options.key?(:minimum) || options.key?(:maximum)
    return false unless value.respond_to?(:size)
    true
  end

  def get_error(array_size, minimum, maximum)
    if array_size > maximum
      "too_long"
    elsif array_size < minimum
      "too_short"
    end
  end
end
