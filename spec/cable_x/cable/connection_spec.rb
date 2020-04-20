require "rails_helper"

describe CableX::Cable::Connection, type: :channel do
  it "successfully connects" do
    connect "/cable_x"
    expect(connection.device_id).not_to eq(nil)
  end
end