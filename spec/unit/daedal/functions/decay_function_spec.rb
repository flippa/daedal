require "spec_helper"

describe Daedal::Functions::DecayFunction do
  subject { described_class }

  describe "#to_hash" do
    context "without the required arguments" do
      it "will raise an error" do
        expect{subject.new.to_hash}.to raise_error(Virtus::CoercionError)
      end
    end

    context "with the minimal valid arguments" do
      let(:expected_hash) do
        {
          my_field: {
            origin: "now",
            scale: "2d"
          }
        }
      end

      it "builds the decay function hash" do
        expect(subject.new(field: :my_field, origin: "now", scale: "2d").to_hash).to eq(expected_hash)
      end
    end

    context "with all valid arguments" do
      let(:expected_hash) do
        {
          my_field: {
            origin: "now-8d",
            scale: "3d",
            offset: "4d",
            decay: 0.36
          }
        }
      end

      it "builds the decay function hash" do
        expect(subject.new(field: :my_field, origin: "now-8d", scale: "3d", offset: "4d", decay: 0.36).to_hash).to eq(expected_hash)
      end
    end
  end
end
