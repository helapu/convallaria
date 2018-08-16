defmodule Convallaria.Shares.ExtinguisherItem do
  use Ecto.Schema
  import Ecto.Changeset


  schema "extinguisher_items" do
    field :desc, :string
    field :name, :string
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(extinguisher_item, attrs) do
    extinguisher_item
    |> cast(attrs, [:uuid, :name, :desc])
    |> validate_required([:uuid, :name, :desc])
  end
end
