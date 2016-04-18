defmodule UCD.NormalizationTests do
	
	def parse_line(line) do
		char_keys = [ :code_value, :canonical_composition, :canonical_decomposition,
									:compatible_composition, :compatible_decomposition ]
		all_keys = char_keys ++ [:c1, :c2, :c3, :c4, :c5, :character_name]
		line
		|> String.split(~r/[;#()]/)
		|> Enum.map(&String.strip/1)
		|> Enum.reject(&(&1 == ""))
		|> Enum.zip(all_keys)
		|> Enum.map(&Tuple.to_list/1)
		|> Enum.reduce(%{}, &(Map.put(&2, List.last(&1), List.first(&1))))
	end

  @normalization_forms [{ :nfc, "canonical composition",
                          [{ :canonical_composition, [ :code_value, :canonical_composition, :canonical_decomposition ]},
                           { :compatible_composition, [ :compatible_composition, :compatible_decomposition ]} ]},
                        { :nfd, "canonical decomposition",
                          [{ :canonical_decomposition, [ :code_value, :canonical_composition, :canonical_decomposition ]},
                           { :compatible_decomposition, [ :compatible_composition, :compatible_decomposition ]} ]}]

	def forms(), do: @normalization_forms
	
	@normalization_tests Path.expand("tmp/TestNormalizationText7.txt")
	# @normalization_tests Path.expand("var/UCD/unicode/NormalizationTests.txt")

	def path(), do: @normalization_tests

	def stream(file \\ path()) do
		File.stream!(file) |> Stream.map(&parse_line/1)
	end

end
