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
    end
    context "With user-dictionary provided" do
    end
  end

  describe "#set_num" do
    subject { WordyNumber.new }
    it "removes punctuations and whitespaces" do
      expect(subject.set_num(" \n k8i0 4568M0! ").num).to eq("8045680")
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

  describe ".join_numbers_together_in_str" do
    subject { WordyNumber }
    it "removes separator between numbers in a string" do
      expect(subject.join_numbers_together_in_str("8-JUS-0-7-1-0-1-6")).to eq("8-JUS-071016")
    end
  end

  describe "#find_all_matches" do
    subject { WordyNumber.new }
    it "returns wordy patterns" do
      expect(subject.set_num("225563").find_all_matches)
      .to include(*%w(BALLO-3 BALK-ME BALL-OF CALL-ME CALL-63 2-ALL-OF BBL-JOE BBL-563 AB-5-JOE AB-KL-OF AC-5-LO-3 AC-55-OF AC-5563 CC-LL-MD 225-LO-3 2255-OF))
      expect(subject.set_num("66473").find_all_matches)
      .to include(*%w(MOIRE NOISE 6-MIRE NOIR-3 OOH-SE 66-HR-3 66-IS-3 NO-IS-3 MN-473 NO-4-RF 66473 664-RF))
      expect(subject.set_num("8587071016").find_all_matches)
      .to include(*["8-JUS-071016", "ULT-7071016", "85-UP-071016", "85-US-071016", "85-VS-071016", "8587071016"])
    end
  end

  describe "#filtered_list" do
    # TODO: Currently I am calling `new` and `find_all_matches` methods here for ease
    # but, we should directly pass a list of strings
    subject { WordyNumber.new }
    it "filters out patterns with consecutive digits" do
      subject.set_num("225563").find_all_matches
      expect(subject.filtered_list)
        .to include(*%w(BALLO-3 BALK-ME BALL-OF CALL-ME 2-ALL-OF BBL-JOE AB-5-JOE AB-KL-OF AC-5-LO-3 CC-LL-MD))
      subject.set_num("225563").find_all_matches
      expect(subject.filtered_list)
        .to_not include(*%w(CALL-63 BBL-563 AC-55-OF AC-5563 225-LO-3 2255-OF))
      subject.set_num("66473").find_all_matches
      expect(subject.filtered_list)
        .to include(*%w(MOIRE NOISE 6-MIRE NOIR-3 OOH-SE NO-IS-3 NO-4-RF))
      subject.set_num("66473").find_all_matches
      expect(subject.filtered_list)
        .to_not include(*%w(66-HR-3 66-IS-3 MN-473 66473 664-RF))
      subject.set_num("8587071016").find_all_matches
      expect(subject.filtered_list)
        .to eq([])
      subject.set_num("8587071016").find_all_matches
      expect(subject.filtered_list)
        .to_not include(*["8-JUS-071016", "ULT-7071016", "85-UP-071016", "85-US-071016", "85-VS-071016", "8587071016"])
    end
    it "raises error unless either num is set of explicit list of strings is passed as argument" do
      expect{subject.filtered_list}.to raise_error(Exception)
    end
  end

  describe "#split_arnd_0_1_n_find_matches" do
    subject { WordyNumber.new }
    it "returns wordy patterns" do
      expect(subject.set_num("225563").split_arnd_0_1_n_find_matches)
      .to include(*%w(BALLO-3 BALK-ME BALL-OF CALL-ME CALL-63 2-ALL-OF BBL-JOE BBL-563 AB-5-JOE AB-KL-OF AC-5-LO-3 AC-55-OF AC-5563 CC-LL-MD 225-LO-3 2255-OF))
      expect(subject.set_num("66473").split_arnd_0_1_n_find_matches)
      .to include(*%w(MOIRE NOISE 6-MIRE NOIR-3 OOH-SE 66-HR-3 66-IS-3 NO-IS-3 MN-473 NO-4-RF 66473 664-RF))
      expect(subject.set_num("8587071016").split_arnd_0_1_n_find_matches)
      .to include(*["8-JUS-071016", "ULT-7071016", "85-UP-071016", "85-US-071016", "85-VS-071016", "8587071016"])
    end
  end

  describe "PRIVATE INTERFACE (for developer)" do
    describe "#scan_dict!" do
    end

    describe "#sanitize_number!" do
    end
  end
end
