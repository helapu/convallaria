defmodule Convallaria.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :nickname, :string
      add :product_key, :string
      add :device_key, :string
      add :device_secret, :string
      add :device_iotid, :string
      add :is_ower, :boolean, default: false, null: false
      
      add :user_id, :integer

      timestamps()
    end

  end
end
