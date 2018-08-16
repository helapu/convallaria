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
      product_key: device.product_key,
      name: device.name,
      secret: device.secret,
      iotid: device.iotid}
  end
end
