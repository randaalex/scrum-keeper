defmodule ScrumKeeper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    port = Application.get_env(:scrum_keeper, :port, 4001)

    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: ScrumKeeper.Router, options: [port: port])
      # Starts a worker by calling: ScrumKeeper.Worker.start_link(arg)
      # {ScrumKeeper.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScrumKeeper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
