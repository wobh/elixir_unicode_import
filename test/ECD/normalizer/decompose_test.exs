defmodule ECD.Normalizer.DecomposeTest do
  use ExUnit.Case, async: true
  alias ECD.Normalizer.Decompose, as: Decompose

  test "Normalize Composition data exists" do
    assert File.exists? Decompose.path
  end

  for {binary, decomposition, codepoint} <- Decompose.stream do
    test "Normalization form Canonical Decomposition: " <>  codepoint do
      assert String.normalize(unquote(binary), :nfd) == unquote(decomposition)
    end
  end
end
