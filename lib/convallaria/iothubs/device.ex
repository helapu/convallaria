defmodule Convallaria.Iothubs.Device do
  use Ecto.Schema
  import Ecto.Changeset


  schema "devices" do
    field :iotid, :string
    field :name, :string
    field :product_key, :string
    field :secret, :string

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:product_key, :name, :secret, :iotid])
    |> validate_required([:product_key, :name, :secret, :iotid])
  end
end
