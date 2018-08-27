defmodule Convallaria.Repo.Migrations.CreateVerifyCodes do
  use Ecto.Migration

  def change do
    create table(:verify_codes) do
      add :verify_code, :string
      add :type, :string
      add :mobile, :string
      add :status, :string
      add :message, :string

      timestamps()
    end

  end
end
