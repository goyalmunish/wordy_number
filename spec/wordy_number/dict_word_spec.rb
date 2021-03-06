describe WordyNumber::DictWord do
  describe "#new" do
    it "sanitizes the passed word (removes punctuations, whitespaces, and even ditigs) and makes it available through #word_form method" do
      ["abc", " abc  ", "\nabc\n", "\rabc\r", "\n\r abc \n\r", "\r\n abc \r\n", "858-A7!BC-$", "ABC"].each do |word|
        dw = WordyNumber::DictWord.new(word)
        expect(dw.word_form).to eq "ABC"
      end
    end

    it "it converts given word to mobile keypad numeric string and makes it available through #numeric_form method" do
      input = {
        CALL: "2255",
        ME: "63",
      }
      input.each do |key, value|
        dw = WordyNumber::DictWord.new(key.to_s)
        expect(dw.numeric_form).to eq value
      end
    end
  end

  describe "#to_s" do
  end

  context "PRIVATE INTERFACE (for developer)" do
    describe "#word_to_numeric_string" do
    end

    describe "#sanitize_word" do
    end
  end
end

