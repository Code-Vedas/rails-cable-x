module ExecWs
  attr_accessor :response
  def exec_cmd(path, params, data, method, request_id)
    perform :cmd, path: path, params: params, data: data, method: method, request_id: request_id
    response = transmissions.last
    expect(response).to include('body')
    expect(response).to include('code')
    expect(response).to include('headers')
    expect(response).to include('request_id')
    expect(response['request_id']).to eq(request_id)
    @response = JSON.parse(response['body']).to_o
  end
end