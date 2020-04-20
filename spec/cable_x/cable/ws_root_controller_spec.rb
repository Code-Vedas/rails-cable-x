require "rails_helper"
describe CableX::Channel::CableXChannel, type: :channel do
  before(:all) do
    stub_connection device_id: SecureRandom.hex(20)
    subscribe
    expect(subscription).to be_confirmed
  end
  it 'subscribe to CableX::Channel::CableXChannel' do
    exec_cmd '/', nil, nil, 'get', '123'
    expect(response.version).to eq(CableX::VERSION)
  end
end