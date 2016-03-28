defmodule ECD.Normalizer.Decompose do
  import ECD.Codepoints, only: [to_binary: 1]

  def parse_line(line) do
    [key, first, second, third, fourth, _] = :binary.split(line, ";", [:global])
    decomposition = to_binary(first) <> (to_binary(second) || "") <>
                                        (to_binary(third)  || "") <>
                                        (to_binary(fourth) || "")
    {to_binary(key), decomposition, "0x#{key}"}
  end

  @decomposition_path Path.expand("var/elixir/unicode/decomposition.txt")

  def path() do
    @decomposition_path
  end

  def stream(file \\ path()) do
    File.stream!(file) |> Stream.map(&parse_line/1)
  end
end
