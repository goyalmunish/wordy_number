require_relative "../lib/wordy_number"

describe WordyNumber do
  describe "#new" do
    context "With no user-dictionary provided" do
      subject { WordyNumber.new }
      it "scans the DEFAULT dictionary" do
        dh = subject.dict_hash
        expect(dh.keys.size).to equal WordyNumber::DEFAULT_DICT_FACTS[:number_of_keys]
        expect(dh.keys.map{|k| dh[k].size}.reduce(:+)).to equal WordyNumber::DEFAULT_DICT_FACTS[:number_of_words]
      end
    end
    context "With user-dictionary provided" do
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
  end
end
