defmodule Convallaria.Frontends.Device do
  require Logger

  import Ecto.Query, warn: false

  alias Convallaria.Repo
  alias Convallaria.Accounts
  alias Convallaria.Iothubs.Product
  alias Convallaria.Iothubs.Device
  alias Convallaria.Iothubs.Follow


  @doc """
  Returns the list of devices.

  ## Examples

      iex> list_devices()
      [%Device{}, ...]

  """
  def list_devices(%{"user_id" => user_id, "page_size" => page_size, "current_page" => current_page} = params) do

    offset = (current_page - 1) * page_size

    query = from d in Follow,
                join: f in Follow,
                where: f.user_id == ^user_id,
                offset: ^offset,
                limit: ^page_size,
                select: d
    # query

    # fetch data from aliyun iothubs and back

    follows = Repo.all(query)


    Repo.all(Device)
  end

  def list_follows(%{"pageSize" => pageSize, "currentPage" => currentPage, "user_id" => user_id} = params) do
    currentPage = if currentPage == 0 do
        1
    else
        currentPage
    end
    
    offset = (currentPage - 1) * pageSize

    query = from d in Device,
                join: f in Follow,
                where: d.id == f.device_id and f.user_id == ^user_id,
                offset: ^offset,
                limit: ^pageSize,
                select: d

    Repo.all(query)
  end

  @doc """
  Gets a single device.

  Raises `Ecto.NoResultsError` if the Device does not exist.

  ## Examples

      iex> get_device!(123)
      %Device{}

      iex> get_device!(456)
      ** (Ecto.NoResultsError)

  """
  def get_device!(id) do
    d = Repo.get!(Device, id)

    params = %{
      "Action" => "QueryDeviceDetail",
      "ProductKey" => d.product_key,
      "DeviceName" => d.key,
      "Version" => "2018-01-20",
    }

    case Convallaria.AliClient.sync_data(params) do
        {:ok, data} ->
          IO.puts "Get data"
          data = Enum.map(data["Data"], fn {k, v} -> {Macro.underscore(k) |> String.to_atom, v} end ) |> Map.new
          d = Map.merge(d, data)
          IO.inspect d
          d
        {:error, error} ->
          IO.puts "raise Error"
          Logger.debug error
          d
    end
    
  end


  @doc """
  Creates a device.

  ## Examples

      iex> create_device(%{field: value})
      {:ok, %Device{}}

      iex> create_device(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_device(attrs \\ %{}) do
    %Device{}
    |> Device.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a device.

  ## Examples

      iex> update_device(device, %{field: new_value})
      {:ok, %Device{}}

      iex> update_device(device, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_device(%Device{} = device, attrs) do
    device
    |> Device.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Device.

  ## Examples

      iex> delete_device(device)
      {:ok, %Device{}}

      iex> delete_device(device)
      {:error, %Ecto.Changeset{}}

  """
  def delete_device(%Device{} = device) do
    Repo.delete(device)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking device changes.

  ## Examples

      iex> change_device(device)
      %Ecto.Changeset{source: %Device{}}

  """
  def change_device(%Device{} = device) do
    Device.changeset(device, %{})
  end

  def get_follow!(%{"user_id" => user_id, "device_key" => device_key}) do
    Repo.get_by!(Follow, user_id: user_id, device_key: device_key)
  end


  def list_follows!(%{"device_key" => device_key}) do
    Repo.all(Follow, device_key: device_key)
  end


  @doc """
  get the follow
  """
  def get_follow!(id) when is_integer(id) do
    Repo.get!(Follow, id)
  end

  def get_follow!(device_key) do
    Repo.get_by!(Follow, device_key: devicke_key)
  end

  def create_follow(attrs \\ %{}) do

    # |> validate_required([：nickname， :product_key, :device_key, :device_secret, :device_iotid, :user_id, :is_ower])
    IO.puts "create follow"
    IO.inspect attrs
    IO.puts attrs["user_id"]

    user = Accounts.get_user! attrs["user_id"] |> String.to_integer
    device = Repo.get!(Device, attrs["device_id"] |> String.to_integer)
    detail = %{
        "product_key" => device.product_key,
        "device_key" => device.key,
        "device_secret" => device.secret,
        "user_id" => attrs["user_id"],
        "is_ower" => attrs["is_ower"]
    }
    %Follow{}
    |> Follow.changeset(detail)
    |> Repo.insert()
  end

end
