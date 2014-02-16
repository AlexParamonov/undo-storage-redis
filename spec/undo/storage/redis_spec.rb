require "spec_helper_lite"
require 'undo/storage/redis'

describe Undo::Storage::Redis do
  let(:adapter) { described_class.new redis }
  let(:redis) { double :redis }

  it "writes hash to redis" do
    expect(redis).to receive(:set).with("123", '{"hello":"world"}')
    adapter.put "123", "hello" => "world"
  end

  it "reads hash from redis" do
    expect(redis).to receive(:get).with("123") { '{"hello":"world"}' }
    expect(adapter.fetch "123").to eq "hello" => "world"
  end
end
