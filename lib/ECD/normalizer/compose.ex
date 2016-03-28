defmodule ECD.Normalizer.Compose do
  import ECD.Codepoints, only: [to_binary: 1]

  def parse_line(line) do
    [first, second, composition, _] = :binary.split(line, ";", [:global])
    key = to_binary(first) <> to_binary(second)
    {key, to_binary(composition), "0x#{composition}"}
  end

  @composition_path Path.expand("var/elixir/unicode/Composition.txt")

  def path() do
    @composition_path
  end

  def stream(file \\ path()) do
    File.stream!(file) |> Stream.map(&parse_line/1)
  end
end
