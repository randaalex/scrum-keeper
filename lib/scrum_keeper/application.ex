defmodule ScrumKeeper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # port = Application.get_env(:scrum_keeper, :port, 4001)
    slack_token = Application.get_env(:scrum_keeper, ScrumKeeper.SlackBot)[:token]
    IO.inspect slack_token

    options = %{keepalive: 10000, name: :scrum_keeper}
    children = [
      ScrumKeeper.Repo,
      worker(Slack.Bot, [ScrumKeeper.SlackBot, [], slack_token, options], [restart: :transient])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScrumKeeper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
