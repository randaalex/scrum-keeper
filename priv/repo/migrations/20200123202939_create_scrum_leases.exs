defmodule ScrumKeeper.Repo.Migrations.CreateScrumLeases do
  use Ecto.Migration

  def change do
    create table(:scrum_leases) do
      add :scrum_number, :string
      add :current_owner, :string
      add :leased_at, :naive_datetime
      add :lease_period, :integer

      timestamps()
    end
  end
end
