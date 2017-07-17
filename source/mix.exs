defmodule Fusun.Mixfile do
  use Mix.Project

  def project do
    [app: :fusun,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Fusun, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, 
                    :postgrex, 
                    :timex,           # A date/time library for Elixir Fully timezone-aware, using the Olson Timezone database - Supports local-timezone lookups - Supports POS...
                    :oauth2,          # An Elixir OAuth 2.0 Client Library
                    :json_web_token,  # Elixir implementation of the JSON Web Token (JWT), RFC 7519
                    :poison,          # An incredibly fast, pure Elixir JSON library
                    :httpoison,       # Yet Another HTTP client for Elixir powered by hackney
                    :comeonin,        # Password hashing (bcrypt, pbkdf2_sha512) library for Elixir.
                    #:exrm,            # Exrm, or Elixir Release Manager, provides mix tasks for building, upgrading, and controlling release packages for your application.
                    :uuid,            # UUID generator
                    #:arc,             # Image Upload 
                    :ex_aws,          # AWS s3
                    :hackney,         # hackney
                    :sweet_xml,       # Sweet xml to help saving multipart data to s3
                  ]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:timex, "~> 3.0"},
     {:oauth2, "> 0.0.0"},
     {:json_web_token, "> 0.0.0"},
     {:poison, "~> 2.0"},
     {:httpoison, "~> 0.9"},
     {:comeonin, "> 0.0.0"},
     #{:exrm, "~> 0.19"},
     {:uuid, "~> 1.1"},
     #{:arc, "~> 0.6.0"},
     # If using Amazon S3:
     {:ex_aws, "~> 1.0.0"},
     {:hackney, "1.6.1"},
     {:sweet_xml, "~> 0.5"}
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
