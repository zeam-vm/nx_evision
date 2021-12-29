defmodule NxEvision.MixProject do
  use Mix.Project

  @source_url "https://github.com/zeam-vm/nx_evision"
  @version "0.1.0-dev"

  def project do
    [
      app: :nx_evision,
      version: @version,
      elixir: "~> 1.12-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.26", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "NxEvision",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
