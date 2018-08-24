defmodule Convallaria.Images.AccountAvatar do
  use Ecto.Schema
  import Ecto.Changeset


  schema "account_avatars" do
    field :url, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(account_avatar, attrs) do
    account_avatar
    |> cast(attrs, [:url, :user_id])
    |> validate_required([:url, :user_id])
  end
end
