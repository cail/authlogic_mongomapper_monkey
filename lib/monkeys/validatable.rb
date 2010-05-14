require 'validatable'

module Validatable 

  class ValidatesNumericalityOf
    option :greater_than, :greater_than_or_equal_to

    def valid?(instance)
      value = value_for(instance)
      return true if allow_nil && value.nil?
      return true if allow_blank && value.blank?
      
      return false if !self.greater_than.nil? and value.to_f <= self.greater_than
      return false if !self.greater_than_or_equal_to.nil? and value.to_f < self.greater_than_or_equal_to
      
      value = value.to_s
      regex = self.only_integer ? /\A[+-]?\d+\Z/ : /^\d*\.{0,1}\d+$/
      not (value =~ regex).nil?
    end
  end


  class Errors
    # Returns an array containing the full list of error messages.
    def full_messages
      full_messages = []

      errors.each_key do |attribute|
        errors[attribute].each do |msg|
          next if msg.nil?

          if attribute.to_s == "base"
            full_messages << msg
          else
            full_messages << humanize(attribute.to_s) + " " + msg.to_s
          end
        end
      end
      full_messages
    end
  end

end
