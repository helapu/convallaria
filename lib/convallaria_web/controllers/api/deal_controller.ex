defmodule ConvallariaWeb.Api.DealController do
  use ConvallariaWeb, :controller

  alias Convallaria.Shares
  alias Convallaria.Shares.Deal

  action_fallback ConvallariaWeb.FallbackController

  def index(conn, _params) do
    deals = Shares.list_deals()
    render(conn, "index.json", deals: deals)
  end

  def create(conn, %{"deal" => deal_params}) do
    with {:ok, %Deal{} = deal} <- Shares.create_deal(deal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", api_deal_path(conn, :show, deal))
      |> render("show.json", deal: deal)
    end
  end

  def show(conn, %{"id" => id}) do
    deal = Shares.get_deal!(id)
    render(conn, "show.json", deal: deal)
  end

  def update(conn, %{"id" => id, "deal" => deal_params}) do
    deal = Shares.get_deal!(id)

    with {:ok, %Deal{} = deal} <- Shares.update_deal(deal, deal_params) do
      render(conn, "show.json", deal: deal)
    end
  end

  def delete(conn, %{"id" => id}) do
    deal = Shares.get_deal!(id)
    with {:ok, %Deal{}} <- Shares.delete_deal(deal) do
      send_resp(conn, :no_content, "")
    end
  end
end
