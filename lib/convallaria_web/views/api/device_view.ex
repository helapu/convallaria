defmodule ConvallariaWeb.Api.DeviceView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.DeviceView

  def render("index.json", %{devices: devices, pageSize: pageSize, currentPage: currentPage}) do
    %{
      data: render_many(devices, DeviceView, "device.json"),
      pageSize: pageSize,
      currentPage: currentPage,
      code: 200
    }
  end

  def render("show.json", %{device: device}) do
    %{
      data: render_one(device, DeviceView, "device.json"),
      code: 200
    }
  end

  def render("device.json", %{device: device}) do
    %{
      product_key: device.product_key,
      name: device.key,
      secret: device.secret,
      iotid: device.iotid
    }
  end

  def render("error.json", %{code: code, message: message}) do
    %{
      code: code,
      message: message
    }
  end

end
