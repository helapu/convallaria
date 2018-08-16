defmodule Convallaria.Iothubs.Product do
  use Ecto.Schema
  import Ecto.Changeset


  schema "products" do
    field :desc, :string
    field :key, :string
    field :name, :string
    field :node_type, :integer
    field :secret, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :key, :secret, :node_type, :desc])
    |> validate_required([:name, :key, :secret, :node_type, :desc])
  end
end
