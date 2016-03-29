defmodule ECD.UnicodeData do

  def read_decomposition_mapping("") do
    %{}
  end

  def read_decomposition_mapping(line = << ?<::utf8, _::binary >>) do
    [tag | mapping] = :binary.split(line, " ", [:global])
    %{tag: tag, mapping: mapping}
  end

  def read_decomposition_mapping(line) do
    %{ mapping: :binary.split(line, " ", [:global]) }
  end

  def parse_line(line) do
    [codepoint, _name, _category,
     _class, _bidi, decomposition,
     _numeric_1, _numeric_2, _numeric_3,
     _bidi_mirror, _unicode_1, _iso,
     upper, lower, title] = :binary.split(line, ";", [:global])
    %{ code_value: codepoint,
       character_decomposition_mapping: read_decomposition_mapping(decomposition),
       uppercase_mapping: upper,
       lowercase_mapping: lower,
       titlecase_mapping: title }
  end

  @unicode_data_path Path.expand("var/elixir/unicode/UnicodeData.txt")

  def path() do
    @unicode_data_path
  end
  
  def stream(file \\ path()) do
    File.stream!(file) |> Stream.map(&parse_line/1)
  end

end
