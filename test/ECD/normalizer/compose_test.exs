defmodule ECD.Normalizer.ComposeTest do
  use ExUnit.Case, async: true
  alias ECD.Normalizer.Compose, as: Compose

  test "Normalize Composition data exists" do
    assert File.exists? Compose.path()
  end

  for {binary, composition, codepoint} <- Compose.stream() do
    test "Normalization form Canonical Composition: " <>  codepoint do
      assert String.normalize(unquote(binary), :nfc) == unquote(composition)
    end
  end
end
