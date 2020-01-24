defmodule ScrumKeeper.Repo do
  use Ecto.Repo,
    otp_app: :scrum_keeper,
    adapter: Ecto.Adapters.Postgres
end
