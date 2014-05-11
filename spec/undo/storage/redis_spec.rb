require "spec_helper_lite"

describe Undo::Storage::Redis do
  subject { described_class.new redis }
  let(:redis) { double :redis }

  it "uses provided storage" do
    subject = described_class.new redis

    expect(redis).to receive :set
    subject.store "foo", "bar"
  end

  it "writes hash as json" do
    expect(redis).to receive(:set).with "123", '{"hello":"world"}', anything
    subject.store "123", "hello" => "world"
  end

  it "reads hash" do
    expect(redis).to receive(:get).with("123") { '{"hello":"world"}' }
    expect(subject.fetch "123").to eq "hello" => "world"
  end

  describe "default options" do
    subject { described_class.new redis, options }
    let(:options) { { additional: :option } }

    it "does not send options to redis.get" do
      expect(redis).to receive(:get).with("foo") { '"bar"' }
      subject.fetch "foo"
    end

    it "does not send options to redis.del" do
      expect(redis).to receive(:del).with "foo"
      subject.delete "foo"
    end

    it "sends provided options to redis.set" do
      expect(redis).to receive(:set).with anything, anything, options
      subject.store "foo", "bar"
    end

    before do
      # JSON.load behaves differently in 1.9
      allow(redis).to receive(:get).with(any_args) { { :foo => :bar }.to_json }
    end if RUBY_VERSION < "2.0"
  end

  describe "options" do
    let(:object) { double :object }
    let(:options) { { foo: :bar } }

    it "accepts options per method" do
      redis.as_null_object

      expect do
        subject.store 123, object, options
        subject.fetch 123, options
        subject.delete 123, options
      end.not_to raise_error
    end

    it "has higher priority than default options" do
      subject = described_class.new redis, ex: 10

      expect(redis).to receive(:set).with anything, anything, ex: 1
      subject.store 123, object, ex: 1
    end
  end
end
