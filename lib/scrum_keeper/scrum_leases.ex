defmodule ScrumKeeper.ScrumLeases do
  use Ecto.Schema

  schema "scrum_leases" do
    field :scrum_number, :string
    field :current_owner, :string
    field :leased_at, :naive_datetime
    field :lease_period, :integer

    timestamps()
  end
end
