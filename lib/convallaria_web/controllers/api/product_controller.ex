defmodule ConvallariaWeb.Api.ProductController do
  use ConvallariaWeb, :controller

  alias Convallaria.Iothubs
  alias Convallaria.Iothubs.Product

  action_fallback ConvallariaWeb.FallbackController

  def index(conn, _params) do
    products = Iothubs.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Iothubs.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Iothubs.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Iothubs.get_product!(id)

    with {:ok, %Product{} = product} <- Iothubs.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Iothubs.get_product!(id)
    with {:ok, %Product{}} <- Iothubs.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
