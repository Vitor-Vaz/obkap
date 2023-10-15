defmodule Obkap.Repo do
  use Ecto.Repo,
    otp_app: :obkap,
    adapter: Ecto.Adapters.Postgres
end
