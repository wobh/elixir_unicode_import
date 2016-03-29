defmodule UCD.Codepoint do

  def to_binary(<<>>), do: nil

  def to_binary(codepoints) when is_binary(codepoints) do
    codepoints = :binary.split(codepoints, ' ', [:global])
    Enum.reduce codepoints, "", fn(codepoint, acc) ->
      {_status, [number], _rest} = :io_lib.fread("~16u", codepoint)
      acc <> << number::utf8 >>
    end
  end

end
