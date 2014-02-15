require "spec_helper_lite"

describe Undo::Storage::Redis do
  let(:adapter) { described_class.new redis }
  let(:redis) { double :redis }

  it "writes string to redis" do
    expect(redis).to receive(:set).with("hello", "world")
    adapter.put "hello", "world"
  end

  it "reads string from redis" do
    expect(redis).to receive(:get).with("hello") { "world" }
    expect(adapter.fetch "hello").to eq "world"
  end

  describe "use json serializer" do
    let(:adapter) { described_class.new redis, serializer: serializer }
    let(:serializer) do
      double :serializer,
        to_json: '{"hello":"world"}',
        from_json: { "hello" => "world" }
    end

    it "writes object to redis" do
      expect(redis).to receive(:set).with("123", '{"hello":"world"}')
      adapter.put "123", "hello" => "world"
    end

    it "reads object from redis" do
      expect(redis).to receive(:get).with("123") { '{"hello":"world"}' }
      expect(adapter.fetch "123").to eq "hello" => "world"
    end
  end
end
