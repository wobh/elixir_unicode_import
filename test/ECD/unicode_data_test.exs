defmodule ECD.UnicodeDataTest do
  use ExUnit.Case

  test "read_decomposition_mapping: empty string" do
    assert ECD.UnicodeData.read_decomposition_mapping("") == %{}
  end

  test "read_decomposition_mapping: tagged mapping" do
    subject = "<compat> 0020 0308"
    assert ECD.UnicodeData.read_decomposition_mapping(subject) == %{ tag: "<compat>", mapping: ["0020", "0308"] }
  end

  test "read_decomposition_mapping: untagged mapping" do
    subject = "0041 0300"
    assert ECD.UnicodeData.read_decomposition_mapping(subject) == %{ mapping: ["0041", "0300"] }
  end

  test "path: Default UnicodeData path exists" do
    assert File.exists? ECD.UnicodeData.path()
  end

  test "stream: returns stream" do
    {_, subject} = ECD.UnicodeData.stream() |> Enum.fetch(0)
    assert subject == %{ character_decomposition_mapping: %{},
                         code_value: "0000",
                         lowercase_mapping: "",
                         titlecase_mapping: "\n",
                         uppercase_mapping: "" }
  end
end
