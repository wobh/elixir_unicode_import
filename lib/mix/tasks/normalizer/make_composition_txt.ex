defmodule Mix.Tasks.Normalizer.MakeCompositionTxt do
  use Mix.Task

  # 0041;0300;00C0;
  # A;̀̀; ;À

  def make_line(%{character_decomposition_mapping: decomp, code_value: codepoint }) do
    cond do
      Map.get(decomp, :tag) ->
        "" # Not a canonical composition, see: ftp://ftp.unicode.org/Public/3.0-Update/UnicodeData-3.0.0.html#Character%20Decomposition
      Map.get(decomp, :mapping) ->
        if Enum.count(decomp.mapping) > 1 do
          Enum.join(decomp.mapping, ";") <> ";" <> codepoint <> ";\n"
        else
          ""
        end
      true ->
        ""
    end
  end

  def run([]) do
    Enum.each ECD.UnicodeData.stream(), fn(character_data) ->
      IO.write make_line(character_data)
    end
  end

  def run([file]) do
    Enum.each ECD.UnicodeData.stream(file), fn(character_data) ->
      IO.write make_line(character_data)
    end
  end
end
