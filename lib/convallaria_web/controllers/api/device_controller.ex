defmodule ConvallariaWeb.Api.DeviceController do
  use ConvallariaWeb, :controller

  alias Convallaria.Iothubs
  alias Convallaria.Iothubs.Device

  action_fallback ConvallariaWeb.FallbackController

  def index(conn, _params) do
    devices = Iothubs.list_devices()
    render(conn, "index.json", devices: devices)
  end

  def create(conn, %{"device" => device_params}) do
    with {:ok, %Device{} = device} <- Iothubs.create_device(device_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_device_path(conn, :show, device))
      |> render("show.json", device: device)
    end
  end

  def show(conn, %{"id" => id}) do
    device = Iothubs.get_device!(id)
    render(conn, "show.json", device: device)
  end

  def update(conn, %{"id" => id, "device" => device_params}) do
    device = Iothubs.get_device!(id)

    with {:ok, %Device{} = device} <- Iothubs.update_device(device, device_params) do
      render(conn, "show.json", device: device)
    end
  end

  def delete(conn, %{"id" => id}) do
    device = Iothubs.get_device!(id)
    with {:ok, %Device{}} <- Iothubs.delete_device(device) do
      send_resp(conn, :no_content, "")
    end
  end
end
