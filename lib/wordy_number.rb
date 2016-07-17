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
  DEFAULT_SEPARATOR = "-"

  attr_accessor :dict
  attr_accessor :num, :num_patterns, :num_filtered_patterns

  # dictionary is expected to have one word per line
  def initialize(user_dictionary=DEFAULT_DICT_FILE_PATH)
    @dict = user_dictionary
    scan_dict!(dict)
  end

  def num=(user_number)
    @num = user_number.to_s
    @num.strip!
    @num.gsub!(/\D/, "")

    @num
  end

  # set_num() is kind of alias to num=(), but helps in chaining
  def set_num(user_number)
    self.num = user_number

    self
  end

  def dict_hash
    @dict_hash = {} unless @dict_hash

    @dict_hash
  end

  def display_dict_stats
    dh = dict_hash
    dh.keys.each{ |key| puts "#{key} -> #{dh[key].size}" }
  end

  def set_num_and_find_matches(user_number)
    set_num(user_number)

    # find matches and filter them
    split_arnd_0_1_n_find_matches
    filtered_list
  end

  def find_all_matches(num_str=self.num, original_call=true, pattern_length=num_str.length)
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
            patterns += self.class.concat_array_of_lists_of_strings([find_all_matches(str1, false), [str2], find_all_matches(str3, false)])
          end
        end
      end
      patterns += find_all_matches(num_str, false, pattern_length-1)
    else
      raise "NotReachableCode"
    end
    patterns.uniq!

    if original_call
      self.num_patterns = patterns
    end

    return patterns
  end

  def self.concat_array_of_lists_of_strings(array_of_lists, separator=DEFAULT_SEPARATOR)
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

  def self.join_numbers_together_in_str(num_str, separator=DEFAULT_SEPARATOR)
    res_str = num_str.gsub(/(\d)#{DEFAULT_SEPARATOR}+(\d)/, '\1\2')
    if res_str != num_str
      return join_numbers_together_in_str(res_str)
    else
      return res_str
    end
  end

  # filter out patterns with consecutive digits
  def filtered_list(list_of_num_strs=self.num_patterns.clone)
    unless list_of_num_strs
      raise "Invalid Argument"
    end
    list_of_num_strs.delete_if{ |pattern| pattern.split(DEFAULT_SEPARATOR).join("") =~ /\d{2}/ }
    self.num_filtered_patterns = list_of_num_strs

    self.num_filtered_patterns
  end

  private

  # it enhances the performance of long numbers carrying 1s or 0s
  def split_arnd_0_1_n_find_matches(num_str=self.num)
    # split given number_string at 0's and 1's
    splits = num_str.gsub(/[^01]/, "").split("")
    split_num_str = num_str.split(/[01]/)
    # obtain patterns for each sub_number_string
    split_results = split_num_str.map do |sub_num_str|
      find_all_matches(sub_num_str)
    end
    # obtain combined result
    combined_splits_and_split_results = []
    split_results.each_index do |index|
      combined_splits_and_split_results << split_results[index]
      combined_splits_and_split_results << [splits[index]] if index <= splits.length - 1
    end
    combined_splits_and_split_results.select!{ |x| x.length > 0 }
    results = self.class.concat_array_of_lists_of_strings(combined_splits_and_split_results)
    # join numbers togeter in each results element
    results.map!{ |str| self.class.join_numbers_together_in_str(str) }
    # set num_patterns
    self.num_patterns = results

    results
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

