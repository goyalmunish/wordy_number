require_relative "../lib/wordy_number"

describe WordyNumber do
  describe "#new" do
    context "With no user-dictionary provided" do
      subject { WordyNumber.new }
      it "scans the DEFAULT dictionary" do
        dh = subject.dict_hash
        expect(dh.keys.size).to equal WordyNumber::DEFAULT_DICT_FACTS[:number_of_keys]
        expect(dh.keys.map{|k| dh[k].size}.reduce(:+)).to eq WordyNumber::DEFAULT_DICT_FACTS[:number_of_words]
      end
      it "sanitizes the passed number and makes it available through #num method"
    end
    context "With user-dictionary provided" do
    end
  end

  describe ".concat_array_of_lists_of_strings" do
    it "returns concatenated prodcts of given array of lists of strings" do
      expect(WordyNumber.concat_array_of_lists_of_strings([["111", "222", "333"], ["aa", "bb"], ["A", "A"]]))
      .to eq(["111-aa-A", "111-aa-A", "111-bb-A", "111-bb-A", "222-aa-A", "222-aa-A", "222-bb-A",
              "222-bb-A", "333-aa-A", "333-aa-A", "333-bb-A", "333-bb-A"])
      expect(WordyNumber.concat_array_of_lists_of_strings([[""], ["aa", "bb"], ["A", "A"]]))
      .to eq(["aa-A", "aa-A", "bb-A", "bb-A"])
      expect(WordyNumber.concat_array_of_lists_of_strings([[""], ["aa", "bb"], [""]]))
      .to eq(["aa", "bb"])
    end
  end

  describe "#find_all_matches" do
    it "returns wordy patterns" do
      expect(WordyNumber.new("225563").find_all_matches)
      .to include(*%w(BALLO-3 BALK-ME BALL-OF CALL-ME CALL-63 2-ALL-OF BBL-JOE BBL-563 AB-5-JOE AB-KL-OF AC-5-LO-3 AC-55-OF AC-5563 CC-LL-MD 225-LO-3 2255-OF))
      expect(WordyNumber.new("66473").find_all_matches)
      .to include(*%w(MOIRE NOISE 6-MIRE NOIR-3 OOH-SE 66-HR-3 66-IS-3 NO-IS-3 MN-473 NO-4-RF 66473 664-RF))
      expect(WordyNumber.new("8587071016").find_all_matches)
      .to include(*["8-JUS-071016", "ULT-7071016", "85-UP-071016", "85-US-071016", "85-VS-071016", "8587071016"])
    end
  end

  describe "#dict_hash" do
    subject { WordyNumber.new }
    it "returns non-empty hash with number as keys" do
      expect(subject.dict_hash).to be_an(Hash)
      expect(subject.dict_hash.keys.size).to be > 0
      subject.dict_hash.keys.each do |key|
        expect(key).to be_an(Integer)
      end
    end
  end

  describe "PRIVATE INTERFACE (for developer)" do
    describe "#scan_dict!" do
    end

    describe "#sanitize_number!" do
    end
  end
end
