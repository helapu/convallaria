defmodule ConvallariaWeb.Api.ExtinguisherItemController do
  use ConvallariaWeb, :controller

  alias Convallaria.Shares
  alias Convallaria.Shares.ExtinguisherItem

  action_fallback ConvallariaWeb.FallbackController

  def index(conn, _params) do
    extinguisher_items = Shares.list_extinguisher_items()
    render(conn, "index.json", extinguisher_items: extinguisher_items)
  end

  def create(conn, %{"extinguisher_item" => extinguisher_item_params}) do
    with {:ok, %ExtinguisherItem{} = extinguisher_item} <- Shares.create_extinguisher_item(extinguisher_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_extinguisher_item_path(conn, :show, extinguisher_item))
      |> render("show.json", extinguisher_item: extinguisher_item)
    end
  end

  def show(conn, %{"id" => id}) do
    extinguisher_item = Shares.get_extinguisher_item!(id)
    render(conn, "show.json", extinguisher_item: extinguisher_item)
  end

  def update(conn, %{"id" => id, "extinguisher_item" => extinguisher_item_params}) do
    extinguisher_item = Shares.get_extinguisher_item!(id)

    with {:ok, %ExtinguisherItem{} = extinguisher_item} <- Shares.update_extinguisher_item(extinguisher_item, extinguisher_item_params) do
      render(conn, "show.json", extinguisher_item: extinguisher_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    extinguisher_item = Shares.get_extinguisher_item!(id)
    with {:ok, %ExtinguisherItem{}} <- Shares.delete_extinguisher_item(extinguisher_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
