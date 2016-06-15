require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Attributor::String do

  subject(:type) { Attributor::String }

  it 'it is not Dumpable' do
    type.new.is_a?(Attributor::Dumpable).should_not be(true)
  end

  context '.native_type' do
    it "returns String" do
      type.native_type.should be(::String)
    end
  end

  context '.example' do
    it "should return a valid String" do
      type.example(options:{regexp: /\w\d{2,3}/}).should be_a(::String)
    end

    it "should return a valid String" do
      type.example.should be_a(::String)
    end

    it 'handles regexps that Randexp can not (#72)' do
      regex = /\w+(,\w+)*/
      expect {
        val = Attributor::String.example(options:{regexp: regex})
        val.should be_a(::String)
        val.should =~ /Failed to generate.+is too vague/
      }.to_not raise_error
    end

  end

  context '.load' do
    let(:value) { nil }

    it 'returns nil for nil' do
      type.load(nil).should be(nil)
    end

    context 'for incoming String values' do

      it 'returns the incoming value' do
        ['', 'foo', '0.0', '-1.0', '1.0', '1e-10', 1].each do |value|
          type.load(value).should eq(String(value))
        end
      end
    end

  end

  context 'for incoming Symbol values' do
    let(:value) { :something }
    it 'returns the stringified-value' do
      type.load(value).should == value.to_s
    end
  end

  context 'for Enumerable values' do
    let(:value) { [1] }

    it 'raises IncompatibleTypeError' do
      expect {
        type.load(value)
      }.to raise_error(Attributor::IncompatibleTypeError)
    end
  end

  context 'json_schema' do
    its(:json_schema_type){ should be(:string)}


    it 'adds regexp as pattern' do
      js = type.as_json_schema(attribute_options: { regexp: /^Foobar$/ })

      expect(js.keys).to include(:pattern)
      expect(js[:pattern]).to eq('^Foobar$')
    end

  end


end
