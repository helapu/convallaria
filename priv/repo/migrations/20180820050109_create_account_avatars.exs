defmodule Convallaria.Repo.Migrations.CreateAccountAvatars do
  use Ecto.Migration

  def change do
    create table(:account_avatars) do
      add :url, :string
      add :user_id, :integer

      timestamps()
    end

  end
end
