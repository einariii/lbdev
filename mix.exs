defmodule Lbdev.MixProject do
  use Mix.Project

  def project do
    [
      app: :lbdev,
      version: "0.1.0",
      elixir: "~> 1.14.3",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      dialyzer: dialyzer(),
      lbdev: lbdev(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Lbdev, []}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras:
        [
          {:"README.md", [title: "Outline"]}
        ] ++
          Path.wildcard("docs/*.md") ++
          [
            "LICENSE.md"
          ]
    ]
  end

  defp dialyzer do
    [
      plt_core_path: "priv/plts",
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp lbdev do
    [
      # This is probably not going to be flat but assumed so for now
      notebooks: "notebooks",
      # Tags should be in the format of: `# base:tag`, these are the defaults
      tags: [
        base: "export",
        lib: "lib",
        test: "test"
      ]
    ]
  end

  defp deps do
    [
      {:file_system, "~> 0.2"},
      {:earmark, "~> 1.4"},
      {:dialyxir, "~> 1.2", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      docs: ["docs --formatter html"],
      "lbdev.server": ["cmd livebook server & mix lbdev"]
    ]
  end
end
