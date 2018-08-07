defmodule Convallaria.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset

  alias Convallaria.Devices.Device


  schema "devices" do
    field :active_time, :utc_datetime
    field :ip, :string
    field :last_online, :utc_datetime
    field :name, :string
    field :secret, :string

    belongs_to :gateway, Device, foreign_key: :gateway_id
    has_many :sub_devices, Device, foreign_key: :gateway_id

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:name, :secret, :active_time, :last_online, :ip, :gateway_id])
    |> validate_required([:name, :secret, :active_time, :last_online, :ip])
  end
end
