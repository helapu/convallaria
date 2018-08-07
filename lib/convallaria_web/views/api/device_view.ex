defmodule ConvallariaWeb.Api.DeviceView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.DeviceView

  def render("index.json", %{devices: devices}) do
    %{data: render_many(devices, DeviceView, "device.json")}
  end

  def render("show.json", %{device: device}) do
    %{data: render_one(device, DeviceView, "device.json")}
  end

  def render("device.json", %{device: device}) do
    %{id: device.id,
      name: device.name,
      secret: device.secret,
      active_time: device.active_time,
      last_online: device.last_online,
      ip: device.ip}
  end
end
