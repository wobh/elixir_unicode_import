defmodule Mix.Tasks.Normalizer.MakeCompositionTxt do
  use ExUnit.Case
  alias Mix.Tasks.Normalizer.MakeCompositionTxt, as: CompTxt

  test "make_line: with empty mapping" do
    assert CompTxt.make_line(%{character_decomposition_mapping: %{}, code_value: "0000" }) == ""
  end

  test "make_line: with tagged mapping" do
    assert CompTxt.make_line(%{character_decomposition_mapping: %{ tag: "<compat>", mapping: ["0020", "0308"] }, code_value: "00A8" }) == ""
  end

  test "make_line: with single mapping" do
    assert CompTxt.make_line(%{character_decomposition_mapping: %{ mapping: ["0300"] }, code_value: "0340" }) == ""
  end

  test "make_line: with untagged mapping" do
    assert CompTxt.make_line(%{character_decomposition_mapping: %{ mapping: ["0041", "0300"] }, code_value: "00C0" }) == "0041;0300;00C0;\n"
  end
end
