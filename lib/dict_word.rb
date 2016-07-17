class DictWord
  attr_accessor :word_form, :numeric_form

  DIGIT_CHARACTER_MAP = {
    :A => 2,
    :B => 2,
    :C => 2,
    :D => 3,
    :E => 3,
    :F => 3,
    :G => 4,
    :H => 4,
    :I => 4,
    :J => 5,
    :K => 5,
    :L => 5,
    :M => 6,
    :N => 6,
    :O => 6,
    :P => 7,
    :Q => 7,
    :R => 7,
    :S => 7,
    :T => 8,
    :U => 8,
    :V => 8,
    :W => 9,
    :X => 9,
    :Y => 9,
    :Z => 9,
  }

  def initialize(word)
    @word_form = word
    sanitize_word!
    word_to_numeric_string!
  end

  def to_s
    "#{word_form}: #{numeric_form}"
  end

  private

  def sanitize_word!
    word = word_form
    word.strip!
    word.upcase!
    word.gsub!(/[^A-Z]/, "")
    self.word_form = word
  end

  def word_to_numeric_string!
    numeric_string = ""
    word_form.split("").each do |c|
      numeric_string << DIGIT_CHARACTER_MAP[c.capitalize.to_sym].to_s
    end

    self.numeric_form = numeric_string
  end
end

