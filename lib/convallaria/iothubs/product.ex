defmodule Convallaria.Iothubs.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :nickname, :string
    field :key, :string
    field :secret, :string
    field :node_type, :integer
    field :description
    
    field :gmt_create, :string, virtual: true
    field :device_count, :integer, virtual: true
    field :category_name, :string, virtual: true
    field :category_key, :string, virtual: true
    field :aliyun_commodity_code, :string, virtual: true

    field :product_name, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:nickname, :key, :secret, :node_type, :description])
    |> validate_required([:nickname, :key, :secret, :node_type, :description])
  end
end
