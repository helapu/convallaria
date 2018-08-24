defmodule Convallaria.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :nickname, :string
      add :product_key, :string
      add :key, :string
      add :secret, :string
      add :iotid, :string

      
      
      timestamps()
    end

  end
end
