defmodule Lbdev.Extract do
  alias Earmark.Internal

  def extract(path, tag \\ "# export") do
    path
    |> File.read!()
    |> Internal.as_ast!()
    |> Enum.map(&extract_tagged(&1, tag))
    |> Enum.reject(fn
      nil -> true
      {nil, _} -> true
      _ -> false
    end)

    # |> Enum.map(&String.trim(elem(&1, 1)))
  end

  def extract_tagged({"pre", [], [{"code", [{"class", "elixir"}], [string], %{}}], %{}}, tag) do
    IO.puts(string)
    # Get something starting with the tag and ending with a newline
    # |> Enum.fetch(0) |> String.trim()
    output = Regex.run(~r/#{tag}.*\n/, string)

    # content = string
    # |> String.replace_leading(output, "")
    # |> String.trim()

    # {output, content}
    {output, string}
  end

  def extract_tagged(_, _), do: nil
end
