defmodule ConvallariaWeb.Api.ProductView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      name: product.name,
      key: product.key,
      secret: product.secret,
      node_type: product.node_type,
      device_type: product.device_type}
  end
end
