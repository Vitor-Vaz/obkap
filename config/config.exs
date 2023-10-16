use Mix.Config

config :obkap,
  ecto_repos: [Obkap.Repo]

config :obkap, ObkapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ymAD2amVtnFoPVkHLdBAuHxzYaX2RZnMx7Wsec+RpNbdKpz2qNjolsqb+WFrvIO4",
  render_errors: [view: ObkapWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Obkap.PubSub,
  live_view: [signing_salt: "POg5mDW7"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
