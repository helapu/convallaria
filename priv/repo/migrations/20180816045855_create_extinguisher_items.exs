defmodule Convallaria.Repo.Migrations.CreateExtinguisherItems do
  use Ecto.Migration

  def change do
    create table(:extinguisher_items) do
      add :uuid, :string
      add :name, :string
      add :desc, :text

      timestamps()
    end

  end
end
