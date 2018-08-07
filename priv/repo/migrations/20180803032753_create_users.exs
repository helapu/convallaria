defmodule Convallaria.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nickname, :string
      add :username, :string
      add :mobile, :string
      add :email, :string
      add :encrypted_password, :string
      add :last_login, :utc_datetime
      add :is_admin, :boolean, default: false, null: false
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
