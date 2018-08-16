defmodule Convallaria.Shares.Deal do
  use Ecto.Schema
  import Ecto.Changeset


  schema "deals" do
    field :back_at, :utc_datetime
    field :charge, :float
    field :item_id, :integer
    field :item_type, :string
    field :share_at, :utc_datetime
    field :status, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(deal, attrs) do
    deal
    |> cast(attrs, [:share_at, :back_at, :charge, :status, :item_id, :item_type, :user_id])
    |> validate_required([:share_at, :back_at, :charge, :status, :item_id, :item_type, :user_id])
  end
end
