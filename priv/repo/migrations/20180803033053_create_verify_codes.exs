defmodule Convallaria.Repo.Migrations.CreateVerifyCodes do
  use Ecto.Migration

  def change do
    create table(:verify_codes) do
      add :code, :string
      add :type, :string
      add :mobile, :string

      timestamps()
    end

  end
end
