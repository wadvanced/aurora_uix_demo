defmodule AuroraUixDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AuroraUixDemoWeb.Telemetry,
      AuroraUixDemo.Repo,
      {DNSCluster, query: Application.get_env(:aurora_uix_demo, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AuroraUixDemo.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AuroraUixDemo.Finch},
      # Start a worker by calling: AuroraUixDemo.Worker.start_link(arg)
      # {AuroraUixDemo.Worker, arg},
      # Start to serve requests, typically the last entry
      AuroraUixDemoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuroraUixDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuroraUixDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
