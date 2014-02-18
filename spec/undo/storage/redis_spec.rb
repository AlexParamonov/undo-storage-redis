require "spec_helper_lite"
require 'undo/storage/redis'

describe Undo::Storage::Redis do
  let(:adapter) { described_class.new redis }
  let(:redis) { double :redis }

  it "writes hash to redis" do
    expect(redis).to receive(:set).with "123", '{"hello":"world"}', anything
    adapter.put "123", "hello" => "world"
  end

  it "reads hash from redis" do
    expect(redis).to receive(:get).with("123", anything) { '{"hello":"world"}' }
    expect(adapter.fetch "123").to eq "hello" => "world"
  end

  describe "options" do
    let(:adapter) { described_class.new redis, options }
    let(:options) { { :additional => :option } }

    it "sends provided options to redis.get" do
      expect(redis).to receive(:get).with anything, options
      adapter.fetch "foo"
    end

    it "sends provided options to redis.set" do
      expect(redis).to receive(:set).with anything, anything, options
      adapter.put "foo", "bar"
    end

    before do
      # JSON.load behaves differently in 1.9
      allow(redis).to receive(:get).with(any_args) { { :foo => :bar }.to_json }
    end if RUBY_VERSION < "2.0"
  end
end
