require "rails_helper"
describe CableX::Channel::CableXChannel, type: :channel do
  it 'subscribe to CableX::Channel::CableXChannel' do
    stub_connection device_id: SecureRandom.hex(20)
    subscribe
    expect(subscription).to be_confirmed
  end
end