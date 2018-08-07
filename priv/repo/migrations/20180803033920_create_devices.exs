defmodule Convallaria.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :name, :string
      add :secret, :string
      add :active_time, :utc_datetime
      add :last_online, :utc_datetime
      add :ip, :string
      
      add :user_id, references(:users, on_delete: :nothing)
      add :gateway_id, references(:devices, on_delete: :nothing)
      
      timestamps()
    end

  end
end
