defmodule Mix.Tasks.GetUCD.CLI do
  use Mix.Task

	@shortdoc "Fetches Unicode Character Database"

	@defaults %{ destination: "var" }

  def run(argv) do
		argv
    |> parse_args
		|> fetch
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv,
                               switches: [ help: :boolean,
                                           noop: :boolean,
                                           destination: :string ],
                               aliases: [ h: :help,
                                          n: :noop,
                                          d: :destination ])
    case parse do
      { [ help: true ], _, _ }
        -> :help
      { [], [version], _ }
        -> %{ :version => version, :options => @defaults }
        { options, [version], _ }
        -> %{ :version => version,
              :options => Map.merge(@defaults, Map.new(options)) }
      _ -> :help
    end
  end

  def fetch(%{:version => version, :options => %{:noop => true}}) do
		version
  end
end
