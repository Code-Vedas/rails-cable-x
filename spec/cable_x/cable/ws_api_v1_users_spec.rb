describe CableX::Channel::CableXChannel, type: :channel do
  before(:all) do
    stub_connection device_id: SecureRandom.hex(20)
    subscribe
    expect(subscription).to be_confirmed
    exec_cmd '/api/v1/users', nil, { user: { first_name: "FN", last_name: 'LN', email: 'fn.ln@example.com' } }, 'post', '123'
  end

  it "Get List of Users" do
    exec_cmd '/api/v1/users', nil, nil, 'get', '123'
    expect(response.users.length).to be >= 0
  end
  it "Get User" do
    exec_cmd '/api/v1/users', nil, nil, 'get', '123'
    expect(response.users.length).to be >= 0
    user = response.users.last

    exec_cmd "/api/v1/users/#{user['id']}", nil, nil, 'get', '123'
    expect(response.user.first_name).to eq('FN')
    expect(response.user.last_name).to eq('LN')
    expect(response.user.email).to eq('fn.ln@example.com')
  end
  it 'Update User' do
    exec_cmd '/api/v1/users', nil, nil, 'get', '123'
    expect(response.users.length).to be >= 0
    user = response.users.last

    exec_cmd "/api/v1/users/#{user['id']}", nil, { user: { first_name: 'FN_A' } }, 'put', '123'

    expect(response.user.first_name).to eq('FN_A')
    expect(response.user.last_name).to eq('LN')
    expect(response.user.email).to eq('fn.ln@example.com')

    exec_cmd "/api/v1/users/#{user['id']}", nil, { user: { first_name: 'FN' } }, 'put', '123'
  end

  it 'Destroy User' do
    exec_cmd '/api/v1/users', nil, nil, 'get', '123'
    expect(response.users.length).to be >= 0
    user = response.users.last
    count = response.users.length

    exec_cmd "/api/v1/users/#{user.id}", nil, nil, 'delete', '123'

    exec_cmd '/api/v1/users', nil, nil, 'get', '123'
    expect(response.users.length).to eq(count - 1)
  end

  it 'Create User' do
    exec_cmd '/api/v1/users', nil, { user: { first_name: "FN", last_name: 'LN', email: 'fn.ln@example.com' } }, 'post', '123'
    expect(response.user.first_name).to eq('FN')
    expect(response.user.last_name).to eq('LN')
    expect(response.user.email).to eq('fn.ln@example.com')
  end
end
