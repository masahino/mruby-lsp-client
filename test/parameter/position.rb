assert("LSP::Parameter::Position") do
  pos = LSP::Parameter::Position.new(1, 2)
  pos_h = pos.to_h
  assert_equal 1, pos_h["line"]
  assert_equal 2, pos_h["character"]
end
