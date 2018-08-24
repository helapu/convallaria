defmodule Convallaria.Iothubs.Device do
  use Ecto.Schema
  import Ecto.Changeset


  schema "devices" do
    field :nickname, :string
    field :product_key, :string
    field :key, :string
    field :secret, :string
    field :iotid, :string

    field :gmt_active, :string, virtual: true
    field :utc_active, :string, virtual: true
    field :gmt_create, :string, virtual: true
    field :utc_create, :string, virtual: true
    field :status, :string, virtual: true
    field :region, :string, virtual: true
    field :node_type, :integer, virtual: true
    field :gmt_online, :string, virtual: true
    field :utc_online, :string, virtual: true
    field :ip_address, :string, virtual: true
    field :firmware_version, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:nickname, :product_key, :key, :secret, :iotid])
    |> validate_required([:nickname, :product_key, :key, :secret, :iotid])
  end
end
