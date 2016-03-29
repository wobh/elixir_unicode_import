# http://www.unicode.org/reports/tr44/#NormalizationTest_txt
# http://www.unicode.org/reports/tr15/

# CONFORMANCE:
# 1. The following invariants must be true for all conformant implementations
#
#    NFC
#      c2 ==  toNFC(c1) ==  toNFC(c2) ==  toNFC(c3)
#      c4 ==  toNFC(c4) ==  toNFC(c5)
#
#    NFD
#      c3 ==  toNFD(c1) ==  toNFD(c2) ==  toNFD(c3)
#      c5 ==  toNFD(c4) ==  toNFD(c5)
#
# ...
#
#
# 2. For every code point X assigned in this version of Unicode that is not specifically
#    listed in Part 1, the following invariants must be true for all conformant
#    implementations:
#
#      X == toNFC(X) == toNFD(X) == toNFKC(X) == toNFKD(X)
#

defmodule UCD.NormalizationTestsTest do 
  use ExUnit.Case, async: true
  alias UCD.NormalizationTests, as: NormTests

	test "constant normalization_tests should return a path" do
		assert File.exists? NormTests.path()
	end
	
	for line <- NormTests.stream() do
		for %{ code_value: code_value, character_name: character_name } <- line do
			for {form_symbol, form_name, form_tests} <- NormTests.forms do
				for {form_expect, form_subjects} <- form_tests do
					for form_subject <- form_subjects do
						test "normalization form #{form_name}" do
							assert String.normalize(UCD.Codepoint.to_binary(line[unquote(form_subject)]),
																			unquote(form_symbol)) ==
								UCD.Codepoint.to_binary(line[(unquote(form_expect))]),
							"#{unquote(code_value)};#{unquote(character_name)}: #{line[unquote(form_expect)]} -> #{line[unquote(form_subject)]}"
						end
					end
				end
			end
		end
	end
end
