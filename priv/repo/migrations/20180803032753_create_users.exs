defmodule Convallaria.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nickname, :string
      add :username, :string
      add :mobile, :string
      add :email, :string
      add :encrypted_password, :string
      add :last_login_at, :utc_datetime
      add :is_admin, :boolean, default: false
      add :is_active, :boolean, default: false
      add :active_at, :utc_datetime

      timestamps()
    end

  end
end
