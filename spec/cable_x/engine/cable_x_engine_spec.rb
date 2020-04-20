describe CableX::Engine do
  it 'should be a class' do
    assert_kind_of Class, CableX::Engine
  end
  it 'method .server should return ActionCable::Server::Base' do
    assert_kind_of ActionCable::Server::Base, CableX::Engine.server
  end
end