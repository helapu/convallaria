defmodule Convallaria.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :nickname, :string
      add :key, :string
      add :secret, :string
      add :node_type, :integer
      add :description, :string

      timestamps()
    end

  end
end
