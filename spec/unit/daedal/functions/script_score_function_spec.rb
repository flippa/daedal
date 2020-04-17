require 'spec_helper'

describe Daedal::Functions::ScriptScoreFunction do

  subject do
    Daedal::Functions::ScriptScoreFunction
  end

  let(:script) { "any script" }

  context 'without a script specified' do
    it 'will raise an error' do
      expect { subject.new(boost: 2) }.to raise_error(Virtus::CoercionError)
    end
  end

  context 'with script specified' do
    let(:query) do
      subject.new(script: script)
    end

    let(:hash_query) do
      { script: script }
    end

    it 'will populate the field and term attributes appropriately' do
      expect(query.script).to eq script
    end
    it 'will have the correct hash representation' do
      expect(query.to_hash).to eq hash_query
    end
    it 'will have the correct json representation' do
      expect(query.to_json).to eq hash_query.to_json
    end
  end
end