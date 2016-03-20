defmodule Mix.Tasks.GetUCD.CLITest do 
  use ExUnit.Case
  doctest Mix.Tasks.GetUCD.CLI

  import Mix.Tasks.GetUCD.CLI, only: [ parse_args: 1, fetch: 1 ]

  test "argument specifies version" do
    assert parse_args(["7.0"]) ==
      %{ :version => "7.0", :options => %{ :destination => "var" } }
    assert parse_args(["8.0"]) ==
      %{ :version => "8.0", :options => %{ :destination => "var" } }
    assert parse_args(["latest"]) ==
      %{ :version => "latest", :options => %{ :destination => "var" } }
  end

  test ":destination option to specify directory of UCD" do
    assert parse_args(["-d", "UCD", "latest"]) ==
      %{ :version => "latest", :options => %{ :destination => "UCD" } }
    assert parse_args(["--destination", "UCD", "latest"]) ==
      %{ :version => "latest", :options => %{ :destination => "UCD" } }
  end

  test ":noop option to just check internet" do
    assert parse_args(["-n", "6.0"]) ==
      %{ :version => "6.0", :options => %{ :noop => true,
                                           :destination => "var" } }
    assert parse_args(["--noop", "6.0"]) ==
      %{ :version => "6.0", :options => %{ :noop => true,
                                           :destination => "var" } }
  end

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test ":garbage option returns help" do
    assert parse_args(["--garbage"]) == :help
  end
end
