defmodule Obkap.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Obkap.Repo,
      ObkapWeb.Telemetry,
      {Phoenix.PubSub, name: Obkap.PubSub},
      ObkapWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Obkap.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ObkapWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
