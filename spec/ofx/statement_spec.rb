describe OFX::Statement do
  let(:parser) { ofx.parser }
  let(:statement) { parser.statements.first }

  context "Bank Account" do
    let(:ofx) { OFX::Parser::Base.new("spec/fixtures/sample.ofx") }

    it "returns currency" do
      expect(statement.currency).to eq("BRL")
    end

    it "returns start date" do
      expect(statement.start_date).to eq(Time.parse("2009-10-09 08:00:00 +0000"))
    end

    it "returns end date" do
      expect(statement.end_date).to eq(Time.parse("2009-11-03 08:00:00 +0000"))
    end

    it "returns account" do
      expect(statement.account).to be_a(OFX::Account)
      expect(statement.account.id).to eq('03227113109')
      expect(statement.account.type).to eq(:checking)
    end

    it "returns transactions" do
      expect(statement.transactions).to be_a(Array)
      expect(statement.transactions.size).to eq(36)
    end

    describe "balance" do
      let(:balance) { statement.balance }

      it "returns balance" do
        expect(balance.amount).to eq(BigDecimal('598.44'))
      end

      it "returns balance in pennies" do
        expect(balance.amount_in_pennies).to eq(59844)
      end

      it "returns balance date" do
        expect(balance.posted_at).to eq(Time.parse("2009-11-01 00:00:00 +0000"))
      end
    end

    describe "available_balance" do
      let(:available_balance) { statement.available_balance }

      it "returns available balance" do
        expect(available_balance.amount).to eq(BigDecimal('1555.99'))
      end

      it "returns available balance in pennies" do
        expect(available_balance.amount_in_pennies).to eq(155599)
      end

      it "returns available balance date" do
        expect(available_balance.posted_at).to eq(Time.parse("2009-11-01 00:00:00 +0000"))
      end

      context "when AVAILBAL not found" do
        let(:ofx) { OFX::Parser::Base.new("spec/fixtures/utf8.ofx") }

        it "returns nil " do
          expect(available_balance).to be_nil
        end
      end
    end
  end

  context "Credit Card" do
    let(:ofx) { OFX::Parser::Base.new("spec/fixtures/creditcard.ofx") }

    it "returns currency" do
      expect(statement.currency).to eq("USD")
    end

    it "returns start date" do
      expect(statement.start_date).to eq(Time.parse("2007-05-09 12:00:00 +0000"))
    end

    it "returns end date" do
      expect(statement.end_date).to eq(Time.parse("2007-06-08 12:00:00 +0000"))
    end

    it "returns account" do
      expect(statement.account).to be_a(OFX::Account)
      expect(statement.account.id).to eq('XXXXXXXXXXXX1111')
    end

    it "returns transactions" do
      expect(statement.transactions).to be_a(Array)
      expect(statement.transactions.size).to eq(3)
    end

    describe "balance" do
      let(:balance) { statement.balance }

      it "returns balance" do
        expect(balance.amount).to eq(BigDecimal('-1111.01'))
      end

      it "returns balance in pennies" do
        expect(balance.amount_in_pennies).to eq(-111101)
      end

      it "returns balance date" do
        expect(balance.posted_at).to eq(Time.parse("2007-06-23 19:20:13 +0000"))
      end
    end

    describe "available_balance" do
      let(:available_balance) { statement.available_balance }

      it "returns available balance" do
        expect(available_balance.amount).to eq(BigDecimal('19000.99'))
      end

      it "returns available balance in pennies" do
        expect(available_balance.amount_in_pennies).to eq(1900099)
      end

      it "returns available balance date" do
        expect(available_balance.posted_at).to eq(Time.parse("2007-06-23 19:20:13 +0000"))
      end
    end
  end
end
