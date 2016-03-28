defmodule ECD.Codepoints do

	def to_binary(""), do: nil

  def to_binary(codepoints) do
    codepoints = :binary.split(codepoints, " ", [:global])
    Enum.reduce codepoints, "", fn(codepoint, acc) ->
      acc <> << String.to_integer(codepoint, 16)::utf8 >>
    end
	end

end
