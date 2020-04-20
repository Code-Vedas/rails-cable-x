describe CableX do
  it "should be a Module" do
    assert_kind_of Module, CableX
  end
  it "has a version number" do
    expect(CableX::VERSION).not_to be nil
  end
end