defmodule Convallaria.Iothubs.Follow do
  use Ecto.Schema
  import Ecto.Changeset


  schema "follows" do
    field :nickname, :string
    field :product_key, :string
    field :device_key, :string
    field :device_secret, :string
    field :device_iotid, :string

    field :is_ower, :boolean, default: false
    field :user_id, :integer

    field :user_name, :string, virtual: true
    field :user_mobile, :string, virtual: true
    field :device_id, :integer, virtual: true

    field :gmt_active, :string, virtual: true
    field :utc_active, :string, virtual: true
    field :gmt_create, :string, virtual: true
    field :utc_create, :string, virtual: true
    field :status, :string, virtual: true
    field :region, :string, virtual: true
    field :node_type, :integer, virtual: true
    field :iotid, :string, virtual: true
    field :gmt_online, :string, virtual: true
    field :utc_online, :string, virtual: true
    field :ip_address, :string, virtual: true
    field :firmware_version, :string, virtual: true

    
    timestamps()
  end

  @doc false
  def changeset(follow, attrs) do
    follow
    |> cast(attrs, [:nickname, :product_key, :device_key, :device_secret, :user_id, :is_ower])
    |> validate_required([:nickname, :product_key, :device_key, :device_secret, :user_id, :is_ower])
  end
end
