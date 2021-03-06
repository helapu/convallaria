defmodule ConvallariaWeb.Admin.ProductController do
  use ConvallariaWeb, :controller

  alias Convallaria.Iothubs
  alias Convallaria.Iothubs.Product

  def index(conn, _params) do
    products = Iothubs.list_products()
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Iothubs.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    case Iothubs.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: admin_product_path(conn, :show, product))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Iothubs.get_product!(id)
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Iothubs.get_product!(id)
    changeset = Iothubs.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Iothubs.get_product!(id)

    params = %{
      "Action" => "UpdateProduct",
      "ProductKey" => product_params["key"],
      "ProductName" => product_params["name"],
      "ProductDesc" => product_params["desc"]
    }

    IO.inspect params
    ali_response = Convallaria.AliClient.sync_data(params)
    IO.inspect ali_response

    case ali_response do
      {:ok, data} ->
        IO.puts "ali_response data"
        IO.inspect data
        if data["Success"] do
          case Iothubs.update_product(product, product_params) do
            {:ok, product} ->
              conn
              |> put_flash(:info, "Product updated successfully.")
              |> redirect(to: admin_product_path(conn, :show, product))
            {:error, %Ecto.Changeset{} = changeset} ->
              render(conn, "edit.html", product: product, changeset: changeset)
          end
        else
          conn
          |> put_flash(:info, "Product updated successfully.")
          |> redirect(to: admin_product_path(conn, :show, product))
        end
       
      {:error, error} ->
        IO.inspect error
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: admin_product_path(conn, :show, product))
    end
    
  end

  def delete(conn, %{"id" => id}) do
    product = Iothubs.get_product!(id)
    {:ok, _product} = Iothubs.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: admin_product_path(conn, :index))
  end
end
