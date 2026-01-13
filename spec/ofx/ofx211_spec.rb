describe OFX::Parser::OFX211 do
  before do
    @ofx = OFX::Parser::Base.new("spec/fixtures/v211.ofx")
    @parser = @ofx.parser
  end

  it "should have a version" do
    expect(OFX::Parser::OFX211::VERSION).to eq("2.1.1")
  end

  it "should set headers" do
    expect(@parser.headers).to eq(@ofx.headers)
  end

  it "should set body" do
    expect(@parser.body).to eq(@ofx.body)
  end

  it "should set account" do
    expect(@parser.account).to be_a(OFX::Account)
  end

  it "should set sign_on" do
    expect(@parser.sign_on).to be_a(OFX::SignOn)
  end

  it "should set accounts" do
    expect(@parser.accounts.size).to eq(2)
  end

  it "should set statements" do
    expect(@parser.statements.size).to eq(2)
    expect(@parser.statements.first).to be_a(OFX::Statement)
  end

  context "transactions" do
    # Test file contains only three transactions. Let's just check
    # them all.
    context "first" do
      before do
        @t = @parser.accounts[0].transactions[0]
      end

      it "should contain the correct values" do
        expect(@t.amount).to eq(BigDecimal('-80'))
        expect(@t.fit_id).to eq("219378")
        expect(@t.memo).to be_empty
        expect(@t.posted_at).to eq(Time.parse("2005-08-24 08:00:00 +0000"))
        expect(@t.name).to eq("FrogKick Scuba Gear")
      end
    end

    context "second" do
      before do
        @t = @parser.accounts[1].transactions[0]
      end

      it "should contain the correct values" do
        expect(@t.amount).to eq(BigDecimal('-23'))
        expect(@t.fit_id).to eq("219867")
        expect(@t.memo).to be_empty
        expect(@t.posted_at).to eq(Time.parse("2005-08-11 08:00:00 +0000"))
        expect(@t.name).to eq("Interest Charge")
      end
    end

    context "third" do
      before do
        @t = @parser.accounts[1].transactions[1]
      end

      it "should contain the correct values" do
        expect(@t.amount).to eq(BigDecimal('350'))
        expect(@t.fit_id).to eq("219868")
        expect(@t.memo).to be_empty
        expect(@t.posted_at).to eq(Time.parse("2005-08-11 08:00:00 +0000"))
        expect(@t.name).to eq("Payment - Thank You")
      end
    end
  end
end

