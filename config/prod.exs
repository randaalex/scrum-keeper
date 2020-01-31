use Mix.Config

# config :scrum_keeper, port: 443
config :scrum_keeper, ScrumKeeper.SlackBot,
  token: System.fetch_env!("SLACK_TOKEN"),
  bot_id: System.fetch_env!("SLACK_BOT_ID")

config :scrum_keeper, ScrumKeeper.Repo,
  url: System.fetch_env!("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true
