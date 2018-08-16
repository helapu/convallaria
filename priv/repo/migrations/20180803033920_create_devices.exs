defmodule Convallaria.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :product_key, :string
      add :name, :string
      add :secret, :string
      add :iotid, :string
      add :user_id, references("users")
      
      timestamps()
    end

  end
end
