import Config

config :obkap, Obkap.Repo,
  username: "obkap_user",
  password: "obkap_password",
  database: "obkap_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :obkap, ObkapWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
