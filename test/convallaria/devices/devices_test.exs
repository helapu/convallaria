defmodule Convallaria.DevicesTest do
  use Convallaria.DataCase

  alias Convallaria.Devices

  describe "products" do
    alias Convallaria.Devices.Product

    @valid_attrs %{device_type: 42, key: "some key", name: "some name", node_type: 42, secret: "some secret"}
    @update_attrs %{device_type: 43, key: "some updated key", name: "some updated name", node_type: 43, secret: "some updated secret"}
    @invalid_attrs %{device_type: nil, key: nil, name: nil, node_type: nil, secret: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Devices.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Devices.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Devices.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Devices.create_product(@valid_attrs)
      assert product.device_type == 42
      assert product.key == "some key"
      assert product.name == "some name"
      assert product.node_type == 42
      assert product.secret == "some secret"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, product} = Devices.update_product(product, @update_attrs)
      assert %Product{} = product
      assert product.device_type == 43
      assert product.key == "some updated key"
      assert product.name == "some updated name"
      assert product.node_type == 43
      assert product.secret == "some updated secret"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_product(product, @invalid_attrs)
      assert product == Devices.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Devices.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Devices.change_product(product)
    end
  end

  describe "devices" do
    alias Convallaria.Devices.Device

    @valid_attrs %{active_time: "2010-04-17 14:00:00.000000Z", ip: "some ip", last_online: "2010-04-17 14:00:00.000000Z", name: "some name", secret: "some secret"}
    @update_attrs %{active_time: "2011-05-18 15:01:01.000000Z", ip: "some updated ip", last_online: "2011-05-18 15:01:01.000000Z", name: "some updated name", secret: "some updated secret"}
    @invalid_attrs %{active_time: nil, ip: nil, last_online: nil, name: nil, secret: nil}

    def device_fixture(attrs \\ %{}) do
      {:ok, device} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Devices.create_device()

      device
    end

    test "list_devices/0 returns all devices" do
      device = device_fixture()
      assert Devices.list_devices() == [device]
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      assert Devices.get_device!(device.id) == device
    end

    test "create_device/1 with valid data creates a device" do
      assert {:ok, %Device{} = device} = Devices.create_device(@valid_attrs)
      assert device.active_time == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert device.ip == "some ip"
      assert device.last_online == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert device.name == "some name"
      assert device.secret == "some secret"
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()
      assert {:ok, device} = Devices.update_device(device, @update_attrs)
      assert %Device{} = device
      assert device.active_time == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert device.ip == "some updated ip"
      assert device.last_online == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert device.name == "some updated name"
      assert device.secret == "some updated secret"
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_device(device, @invalid_attrs)
      assert device == Devices.get_device!(device.id)
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = Devices.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_device!(device.id) end
    end

    test "change_device/1 returns a device changeset" do
      device = device_fixture()
      assert %Ecto.Changeset{} = Devices.change_device(device)
    end
  end
end
