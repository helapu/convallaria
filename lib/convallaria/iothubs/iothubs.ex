defmodule Convallaria.Iothubs do
  @moduledoc """
  The Iothubs context.
  """

  require Logger
  import Ecto.Query, warn: false
  alias Convallaria.Repo

  alias Convallaria.Accounts

  alias Convallaria.Iothubs.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id) do
      p = Repo.get!(Product, id)

      params = %{
        "Action" => "QueryProduct",
        "ProductKey" => p.key,
      }

      case Convallaria.AliClient.sync_data(params) do
          {:ok, data} ->
            IO.puts "Get data"
            data = Enum.map(data["ProductInfo"], fn {k, v} -> {Macro.underscore(k) |> String.to_atom, v} end ) |> Map.new
            p = Map.merge(p, data)
            IO.inspect p
            p
          {:error, error} ->
            IO.puts "raise Error"
            Logger.debug error
            p
      end
      
  end
#   def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{source: %Product{}}

  """
  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  alias Convallaria.Iothubs.Device

  @doc """
  Returns the list of devices.

  ## Examples

      iex> list_devices()
      [%Device{}, ...]

  """
  def list_devices do
    Repo.all(Device)
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
  def get_device!(id) when is_integer(id) do
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
  def get_device!(%{"device_key" => device_key}) do
    Repo.get_by!(Device, key: device_key)
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


  alias Convallaria.Iothubs.Follow

  @doc """
  Returns the list of follows.

  ## Examples

      iex> list_follows()
      [%Follow{}, ...]

  """
  def list_follows do
      Repo.all(Follow)
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
  Gets a single follow.

  Raises `Ecto.NoResultsError` if the Follow does not exist.

  ## Examples

      iex> get_follow!(123)
      %Follow{}

      iex> get_follow!(456)
      ** (Ecto.NoResultsError)

  """

  def get_follow!(id) do
    d = Repo.get!(Follow, id)
  
    params = %{
      "Action" => "QueryDeviceDetail",
      "ProductKey" => d.product_key,
      "DeviceName" => d.device_key,
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

  
  def get_device_by_follow!(id) do
      f = Repo.get!(Follow, id)
      Repo.get!(Device, f.device_id)
  end

  @doc """
  Creates a follow.

  ## Examples

      iex> create_follow(%{field: value})
      {:ok, %Follow{}}

      iex> create_follow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
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

  @doc """
  Updates a follow.

  ## Examples

      iex> update_follow(follow, %{field: new_value})
      {:ok, %Follow{}}

      iex> update_follow(follow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_follow(%Follow{} = follow, attrs) do
    follow
    |> Follow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Follow.

  ## Examples

      iex> delete_follow(follow)
      {:ok, %Follow{}}

      iex> delete_follow(follow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_follow(%Follow{} = follow) do
    Repo.delete(follow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking follow changes.

  ## Examples

      iex> change_follow(follow)
      %Ecto.Changeset{source: %Follow{}}

  """
  def change_follow(%Follow{} = follow) do
    Follow.changeset(follow, %{})
  end

end
