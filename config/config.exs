use Mix.Config

config :scrum_keeper, ecto_repos: [ScrumKeeper.Repo]

import_config "#{Mix.env}.exs"
