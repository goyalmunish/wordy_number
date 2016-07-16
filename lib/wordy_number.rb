require_relative 'dict_word'

class WordyNumber

  # Dictioary hash structures looks like following
  # dict_hash = {
  # 1 => [{:word_form=>"a", :numeric_form=>"2"}],
  # ,...,
  # 23 => [{:word_form=>"disestablismentarianism", :numeric_form=>"34737822547636827426476"},
  #        {:word_form=>"electroencephalographic", :numeric_form=>"35328763623742564727442"}],
  # }

  DICT_DIR = File.expand_path("../public", File.dirname(__FILE__))
  DEFAULT_DICT_FILE_NAME = "wordsEn.txt"
  DEFAULT_DICT_FILE_PATH = File.expand_path(DEFAULT_DICT_FILE_NAME, DICT_DIR)
  DEFAULT_DICT_FACTS = {
    number_of_keys: 25,
    number_of_words: 109582,
  }

  attr_accessor :num, :dict, :patterns

  # dictionary is expected to have one word per line
  def initialize(user_number="", user_dictionary=DEFAULT_DICT_FILE_PATH)
    @num = user_number
    sanitize_number!
    @dict = user_dictionary
    scan_dict!(dict)
    @patterns = []
  end

  def dict_hash
    @dict_hash = {} unless @dict_hash

    @dict_hash
  end

  def display_dict_stats
    dh = dict_hash
    dh.keys.each{ |key| puts "#{key} -> #{dh[key].size}" }
  end

  # it enhances the performance of long numbers carrying 1s
  def split_arnd_1_and_find_matches(num_str=self.num)
    results = num_str.split("1").map do |sub_num_str|
      find_all_matches(sub_num_str)
    end
    self.class.concat_array_of_lists_of_strings(results, "-1-")
  end

  def find_all_matches(num_str=self.num, pattern_length=num_str.length)  # can the order cause issue here
    patterns = []
    if num_str.size == 0  # first deal with the edge cases
      return patterns
    end
    if pattern_length == 1  # first deal with the edge cases
      if dict_hash[pattern_length]
        times = 0
        dict_hash[pattern_length].each do |dict_word|
          if num_str == dict_word
            times += 1
            patterns << dict_word.word_form
          end
        end
        if times == 0
          patterns << num_str
        end
      end
    elsif pattern_length > 0  # general case
      if dict_hash[pattern_length]
        dict_hash[pattern_length].each do |dict_word|
          matched_index = num_str =~ /#{dict_word.numeric_form}/
          if matched_index
            str1 = matched_index > 0 ? num_str[0..(matched_index - 1)] : ""
            str2 = dict_word.word_form  # it has word_form, but str1 and str3 still have numeric_form
            str3 = num_str[(matched_index + pattern_length)..-1]
            patterns += self.class.concat_array_of_lists_of_strings([find_all_matches(str1), [str2], find_all_matches(str3)])
          end
        end
      end
      patterns += find_all_matches(num_str, pattern_length-1)
    else
      raise "NotReachableCode"
    end

    return patterns.uniq
  end

  def self.concat_array_of_lists_of_strings(array_of_lists, separator="-")
    # remove empty elements
    array_of_lists.each do |list|
      list.delete_if{ |elem| elem.length == 0 }
    end
    # remove empty lists
    array_of_lists.select!{ |list| list.size > 0 }

    # calculate product
    result = if array_of_lists.size > 1
      array_of_lists[0].product(*array_of_lists[1..-1]).map{ |elem| elem.join(separator) }
    elsif array_of_lists.size == 1
      array_of_lists[0]
    else
      # array_of_lists.size == 0
      []
    end

    result
  end

  private

  def sanitize_number!
    number_str = self.num
    number_str.strip!
    self.num = number_str
  end

  def scan_dict!(dict_file_path=DEFAULT_DICT_FILE_PATH)
    # reset dict_hash
    dh = dict_hash
    dh.clear

    # load dictionary
    File.open(dict_file_path, "r") do |file|
      file.each_line do |line|
        dw = DictWord.new(line)
        dh[dw.word_form.length] = [] unless dh[dw.word_form.length]  # `dw.word` is sanitized but `line` is not
        dh[dw.word_form.length] << DictWord.new(line)
      end
    end

    dh
  end
end

