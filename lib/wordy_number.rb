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

  attr_accessor :num, :dict

  # dictionary is expected to have one word per line
  def initialize(user_number=nil, user_dictionary=DEFAULT_DICT_FILE_PATH)
    self.num = user_number
    sanitize_number!
    self.dict = user_dictionary
    scan_dict!(dict)
  end

  def dict_hash
    @dict_hash = {} unless @dict_hash

    @dict_hash
  end

  def display_dict_stats
    dh = dict_hash
    dh.keys.each{ |key| puts "#{key} -> #{dh[key].size}" }
  end

  private

  def sanitize_number!
    #TODO: yet to implement
  end

  def scan_dict!(dict_file_path = DEFAULT_DICT_FILE_PATH)
    # reset dict_hash
    dh = dict_hash
    dh.clear

    # load dictionary
    File.open(dict_file_path, "r") do |file|
      file.each_line do |line|
        dh[line.length] = [] unless dh[line.length]
        dh[line.length] << DictWord.new(line)
      end
    end

    dh
  end
end

