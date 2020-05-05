require "rails_helper"

describe CableX::Cable::Connection, type: :channel do
  before(:all) do
    @server = CableX::Engine.server
  end
  it "Return type:error to websocket if message is not valid JSON" do
    run_in_eventmachine do
      setup_connection
      @connection.receive('ADF')
      expect(last_message[:type]).to eq("error")
      expect(last_message[:message]).to eq("malformed_message")
    end
  end
  it "Send close message and closes websocket if second limit is crossed" do
    run_in_eventmachine do
      setup_connection
      config = Rails.application.config_for(:cable)
      redis = Redis.new(url: config[:url])
      redis.flushall
      @connection.connect
      3.times do
        @connection.receive(ActiveSupport::JSON.encode(message: 'Message'))
      end
      expect(last_message[:type]).to eq("disconnect")
      expect(last_message[:reason]).to eq("Rate limiting: Limit exceeded for per second Slow down!. Try after some time")
    end
  end
  it "Send close message and closes websocket if minute limit is crossed" do
    run_in_eventmachine do
      setup_connection
      config = Rails.application.config_for(:cable)
      redis = Redis.new(url: config[:url])
      redis.flushall
      @connection.connect
      @connection.rate_limit[:second] = 40
      12.times do
        @connection.receive(ActiveSupport::JSON.encode(message: 'Message'))
      end
      expect(last_message[:type]).to eq("disconnect")
      expect(last_message[:reason]).to eq("Rate limiting: Limit exceeded for per minute Slow down!. Try after some time")
    end
  end
  it "Send close message and closes websocket if hour limit is crossed" do
    run_in_eventmachine do
      setup_connection
      config = Rails.application.config_for(:cable)
      redis = Redis.new(url: config[:url])
      redis.flushall
      @connection.connect
      @connection.rate_limit[:second] = 70
      @connection.rate_limit[:minute] = 70
      61.times do
        @connection.receive(ActiveSupport::JSON.encode(message: 'Message'))
      end
      expect(last_message[:type]).to eq("disconnect")
      expect(last_message[:reason]).to eq("Rate limiting: Limit exceeded for per hour Slow down!. Try after some time")
    end
  end
  it "It rejects and disconnects if blocked client wants to connect" do
    run_in_eventmachine do
      setup_connection
      config = Rails.application.config_for(:cable)
      redis = Redis.new(url: config[:url])
      redis.flushall
      @connection.connect
      @connection.rate_limit[:second] = 2
      @connection.rate_limit[:hour] = 70
      @connection.rate_limit[:minute] = 70
      3.times do
        @connection.receive(ActiveSupport::JSON.encode(message: 'Message'))
      end
      expect(last_message[:type]).to eq("disconnect")
      expect(last_message[:reason]).to eq("Rate limiting: Limit exceeded for per second Slow down!. Try after some time")

      expect{@connection.connect}.to raise_error(ActionCable::Connection::Authorization::UnauthorizedError)
    end
  end
  private

  def setup_connection
    env = Rack::MockRequest.env_for "/cable_x", "HTTP_HOST" => "localhost", "HTTP_CONNECTION" => "upgrade", "HTTP_UPGRADE" => "websocket"
    @connection = CableX::Cable::Connection.new(@server, env)
  end
end