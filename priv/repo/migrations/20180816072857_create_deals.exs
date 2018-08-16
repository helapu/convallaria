defmodule Convallaria.Repo.Migrations.CreateDeals do
  use Ecto.Migration

  def change do
    create table(:deals) do
      add :share_at, :utc_datetime
      add :back_at, :utc_datetime
      add :charge, :float
      add :status, :integer
      add :item_id, :integer
      add :item_type, :string
      add :user_id, :integer

      timestamps()
    end

  end
end
