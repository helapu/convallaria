defmodule Convallaria.Repo.Migrations.CreateShareGallerys do
  use Ecto.Migration

  def change do
    create table(:share_gallerys) do
      add :url, :string
      add :item_type, :string
      add :item_id, :integer

      timestamps()
    end

  end
end
