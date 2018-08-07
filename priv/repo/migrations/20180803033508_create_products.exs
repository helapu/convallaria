defmodule Convallaria.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :key, :string
      add :secret, :string
      add :node_type, :integer
      add :device_type, :integer

      timestamps()
    end

  end
end
