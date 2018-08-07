defmodule Convallaria.Devices.Product do
  use Ecto.Schema
  import Ecto.Changeset


  schema "products" do
    field :device_type, :integer
    field :key, :string
    field :name, :string
    field :node_type, :integer
    field :secret, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :key, :secret, :node_type, :device_type])
    |> validate_required([:name, :key, :secret, :node_type, :device_type])
  end
end
