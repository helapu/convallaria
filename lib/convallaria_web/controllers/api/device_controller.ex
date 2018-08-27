defmodule ConvallariaWeb.Api.DeviceController do
  use ConvallariaWeb, :controller

  alias Convallaria.Iothubs.Device
  alias Convallaria.Iothubs.Follow
  alias Convallaria.Frontends

  action_fallback ConvallariaWeb.Api.FallbackController

  def index(conn, params) do
    page_size = Map.get(params, "page_size", 10)
    current_page = Map.get(params, "current_page", 1)
    user = current_user(conn)

    devices = Frontends.list_devices(%{"page_size" => String.to_integer(page_size), "current_page" => String.to_integer(current_page), "user_id" => user.id })
    render(conn, "index.json", devices: devices, page_size:  page_size, current_page:  current_page)
  end

  @doc """
  add follow data. first add as ower second add as sharer
  """
  def create(conn, %{"device_key" => device_key, "is_share" => true}) do
    user = current_user(conn)

    f =  Frontends.get_follow!(%{"device_key" => device_key, "user_id": user.id})
    device_follows = Frontends.get_follow!(%{"device_key" => device_key})

    if (device_follows |> Enum.count) < 10 do
      with {:ok, %Device{} = device} <- Frontends.Device.create_follow() do
        conn
        |> render("show.json", device: device)
      end
    else
      {:error, :follower_too_much}
    end

  end

  @doc """
  show follow device
  """
  def show(conn, %{"device_key" => device_key}) do
    device = Frontends.get_follow!(device_key)#Iothubs.get_device_by_follow!(id)
    render(conn, "show.json", device: device)
  end

  @doc """
  controller the device if is the ower
  """
  def update(conn, %{"device_key" => device_key, "device" => device_params}) do
    device = Frontends.get_device!(device_key)

    with {:ok, %Device{} = device} <- Iothubs.update_device(device, device_params) do
      render(conn, "show.json", device: device)
    end
  end

  @doc """
  unfollow a device unless your are not the ower
  the ower can not unfollow the device
  """
  def delete(conn, %{"device_key" => device_key}) do

    follow = Frontends.get_follow!(device_key)
    if follow.is_ower do
      render(conn, "error.json", code: 200)
    else
      with {:ok, %Follow{}} <- Iothubs.delete_follow(follow) do
        send_resp(conn, :no_content, "")
      end
    end

  end

end
