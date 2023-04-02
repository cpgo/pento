defmodule Cpgo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CpgoWeb.Telemetry,
      # Start the Ecto repository
      Cpgo.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Cpgo.PubSub},
      # Start Finch
      {Finch, name: Cpgo.Finch},
      # Start the Endpoint (http/https)
      CpgoWeb.Endpoint
      # Start a worker by calling: Cpgo.Worker.start_link(arg)
      # {Cpgo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cpgo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CpgoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
