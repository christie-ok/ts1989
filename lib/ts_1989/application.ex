defmodule Ts1989.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Ts1989Web.Telemetry,
      # Start the Ecto repository
      Ts1989.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ts1989.PubSub},
      # Start Finch
      {Finch, name: Ts1989.Finch},
      # Start the Endpoint (http/https)
      Ts1989Web.Endpoint
      # Start a worker by calling: Ts1989.Worker.start_link(arg)
      # {Ts1989.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ts1989.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Ts1989Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
