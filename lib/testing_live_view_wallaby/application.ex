defmodule TestingLiveViewWallaby.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TestingLiveViewWallaby.Repo,
      # Start the Telemetry supervisor
      TestingLiveViewWallabyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestingLiveViewWallaby.PubSub},
      # Start the Endpoint (http/https)
      TestingLiveViewWallabyWeb.Endpoint
      # Start a worker by calling: TestingLiveViewWallaby.Worker.start_link(arg)
      # {TestingLiveViewWallaby.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestingLiveViewWallaby.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestingLiveViewWallabyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
