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

  @normalization_tests Path.expand("var/UCD/TestNormalizationText7.txt")

  # test "constant normalization_tests should return a path" do
  #   File.exists? @normalization_tests
  # end

  # {{:nfc, "canonical composition", {{c2, {c1, c2, c3}}, {c4, {c4, c5}}}},
  #  {:nfd, "canonical decomposition", {{c3, {c1, c2, c3}}, {c5, {c4, c5}}}}}

  @normalization_fixtures Enum.map File.stream!(@normalization_tests), fn(line) ->
    NormTests.parse_line(line)
  end

  for %{ n1: _n1, n2: _n2, n3: _n3, n4: _n4, n5: _n5, name: char_name } <- NormTests.stream do
    for {_form_symbol, form_name, form_tests} <- NormTests.forms do
      for {form_expect, form_subjects} <- form_tests do
        for form_subject <- form_subjects do
          test "Normalization form #{form_name}: #{char_name}: #{form_expect} -> #{form_subject}" do
            assert unquote(form_subject) |> UCD.Codepoint.to_binary |> String.normalize == unquote(form_expect) |> UCD.Codepoint.to_binary
          end
        end
      end
    end
  end
end
  # with {_, %{ n1: n1, n2: n2, n3: n3, n4: n4, n5: n5, c1: c1, c2: c2, c3: c3, c4: c4, c5: c5, name: name }} <- Enum.fetch(@normalization_fixtures, 0) do
  #   test "Normalize canonical composition: #{name}: #{n1} -> #{n2}" do
  #     assert String.normalize(unquote(n1)), :nfc) == unquote(n2)
  #   end
  #   test "Normalize canonical composition #{n2} -> #{n2}" do
  #     assert String.normalize(unquote(n2), :nfc) == unquote(n2)
  #   end
  #   test "Normalize canonical composition #{n3} -> #{n2}" do
  #     assert String.normalize(unquote(n3), :nfc) == unquote(n2)
  #   end
  #   test "Normalize canonical composition #{n4} -> #{n4}" do
  #     assert String.normalize(unquote(n4), :nfc) == unquote(n4)
  #   end
  #   test "Normalize canonical composition #{n5} -> #{n4}" do
  #     assert String.normalize(unquote(n5), :nfc) == unquote(n4)
  #   end

    # test "Normalize canonical decomposition  #{unquote(c1)} -> #{unquote(c3)}" do
    #   assert String.normalize(unquote(c1), :nfd) == unquote(c3)
    # end
    # test "Normalize canonical decomposition  #{unquote(c2)} -> #{unquote(c3)}" do
    #   assert String.normalize(unquote(c2), :nfd) == unquote(c3)
    # end
    # test "Normalize canonical decomposition  #{unquote(c3)} -> #{unquote(c3)}" do
    #   assert String.normalize(unquote(c3), :nfd) == unquote(c3)
    # end
    # test "Normalize canonical decomposition  #{unquote(c4)} -> #{unquote(c5)}" do
    #   assert String.normalize(unquote(c4), :nfd) == unquote(c5)
    # end
    # test "Normalize canonical decomposition  #{unquote(c4)} -> #{unquote(c5)}" do
    #   assert String.normalize(unquote(c4), :nfd) == unquote(c5)
    # end
  # end   

  # for %{ c1: c1, c2: c2, c3: c3, c4: c4, c5: c5, name: name} <- normalization_fixtures do
  #   test "Normalize canonical composition " <> name do
  #     assert test_every(unquote_splicing([c1, c2, c3]), unquote(c2), %{key: &(String.normalize(&1, :nfc))})
  #     assert test_every(unquote_splicing([c4, c5]), unquote(c4), %{key: &(String.normalize(&1, :nfc))})
  #   end
  #   test "Normalize with canonical decomposition " <> name do
  #     assert test_every(unquote_splicing([c1, c2, c3]), unquote(c3), %{key: &(String.normalize(&1, :nfd))})
  #     assert test_every(unquote_splicing([c4, c5]), unquote(c5), %{key: &(String.normalize(&1, :nfd))})
  #   end
  # end


 
