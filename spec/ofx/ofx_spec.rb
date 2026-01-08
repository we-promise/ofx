require "spec_helper"

describe OFX do
  describe "#OFX" do
    it "should yield an OFX instance" do
      OFX("spec/fixtures/sample.ofx") do |ofx|
        expect(ofx).to be_a(OFX::Parser::OFX102)
      end
    end

    it "should return parser" do
      expect(OFX("spec/fixtures/sample.ofx")).to be_a(OFX::Parser::OFX102)
    end
  end
end
