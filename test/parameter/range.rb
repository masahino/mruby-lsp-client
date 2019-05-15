assert("LSP::Parameter::Range") do
  r = LSP::Parameter::Range.new(1, 2, 3, 4)
  r_h = r.to_h
  assert_equal 1, r_h["start"]["line"]
  assert_equal 2, r_h["start"]["character"]
  assert_equal 3, r_h["end"]["line"]
  assert_equal 4, r_h["end"]["character"]
end