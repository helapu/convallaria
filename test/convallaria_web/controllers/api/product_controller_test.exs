defmodule ConvallariaWeb.Api.ProductControllerTest do
  use ConvallariaWeb.ConnCase

  alias Convallaria.Devices
  alias Convallaria.Devices.Product

  @create_attrs %{device_type: 42, key: "some key", name: "some name", node_type: 42, secret: "some secret"}
  @update_attrs %{device_type: 43, key: "some updated key", name: "some updated name", node_type: 43, secret: "some updated secret"}
  @invalid_attrs %{device_type: nil, key: nil, name: nil, node_type: nil, secret: nil}

  def fixture(:product) do
    {:ok, product} = Devices.create_product(@create_attrs)
    product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get conn, api_product_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post conn, api_product_path(conn, :create), product: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, api_product_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "device_type" => 42,
        "key" => "some key",
        "name" => "some name",
        "node_type" => 42,
        "secret" => "some secret"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, api_product_path(conn, :create), product: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product" do
    setup [:create_product]

    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = put conn, api_product_path(conn, :update, product), product: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, api_product_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "device_type" => 43,
        "key" => "some updated key",
        "name" => "some updated name",
        "node_type" => 43,
        "secret" => "some updated secret"}
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put conn, api_product_path(conn, :update, product), product: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete conn, api_product_path(conn, :delete, product)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, api_product_path(conn, :show, product)
      end
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    {:ok, product: product}
  end
end
