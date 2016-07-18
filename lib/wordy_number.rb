require "wordy_number/version"
require "wordy_number/dict_word"
require "wordy_number/wordy_match"

module WordyNumber
  # custom Exceptions
  class Error < StandardError;end

  class StartsWithNonRepeatableRomanUnitError < Error;end

  class NonReachableCodeError < Error;end

  class InvalidInputError < Error;end

end

