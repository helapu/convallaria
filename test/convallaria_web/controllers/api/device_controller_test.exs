defmodule ConvallariaWeb.Api.DeviceControllerTest do
  use ConvallariaWeb.ConnCase

  alias Convallaria.Devices
  alias Convallaria.Devices.Device

  @create_attrs %{active_time: "2010-04-17 14:00:00.000000Z", ip: "some ip", last_online: "2010-04-17 14:00:00.000000Z", name: "some name", secret: "some secret"}
  @update_attrs %{active_time: "2011-05-18 15:01:01.000000Z", ip: "some updated ip", last_online: "2011-05-18 15:01:01.000000Z", name: "some updated name", secret: "some updated secret"}
  @invalid_attrs %{active_time: nil, ip: nil, last_online: nil, name: nil, secret: nil}

  def fixture(:device) do
    {:ok, device} = Devices.create_device(@create_attrs)
    device
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all devices", %{conn: conn} do
      conn = get conn, api_device_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create device" do
    test "renders device when data is valid", %{conn: conn} do
      conn = post conn, api_device_path(conn, :create), device: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, api_device_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "active_time" => "2010-04-17 14:00:00.000000Z",
        "ip" => "some ip",
        "last_online" => "2010-04-17 14:00:00.000000Z",
        "name" => "some name",
        "secret" => "some secret"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, api_device_path(conn, :create), device: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update device" do
    setup [:create_device]

    test "renders device when data is valid", %{conn: conn, device: %Device{id: id} = device} do
      conn = put conn, api_device_path(conn, :update, device), device: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, api_device_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "active_time" => "2011-05-18 15:01:01.000000Z",
        "ip" => "some updated ip",
        "last_online" => "2011-05-18 15:01:01.000000Z",
        "name" => "some updated name",
        "secret" => "some updated secret"}
    end

    test "renders errors when data is invalid", %{conn: conn, device: device} do
      conn = put conn, api_device_path(conn, :update, device), device: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete device" do
    setup [:create_device]

    test "deletes chosen device", %{conn: conn, device: device} do
      conn = delete conn, api_device_path(conn, :delete, device)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, api_device_path(conn, :show, device)
      end
    end
  end

  defp create_device(_) do
    device = fixture(:device)
    {:ok, device: device}
  end
end
