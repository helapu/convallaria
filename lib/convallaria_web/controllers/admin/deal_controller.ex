defmodule ConvallariaWeb.Admin.DealController do
  use ConvallariaWeb, :controller

  alias Convallaria.Shares
  alias Convallaria.Shares.Deal

  def index(conn, _params) do
    deals = Shares.list_deals()
    render(conn, "index.html", deals: deals)
  end

  def new(conn, _params) do
    changeset = Shares.change_deal(%Deal{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"deal" => deal_params}) do
    case Shares.create_deal(deal_params) do
      {:ok, deal} ->
        conn
        |> put_flash(:info, "Deal created successfully.")
        |> redirect(to: admin_deal_path(conn, :show, deal))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    deal = Shares.get_deal_detail!(id)
    render(conn, "show.html", deal: deal)
  end

  def edit(conn, %{"id" => id}) do
    deal = Shares.get_deal!(id)
    changeset = Shares.change_deal(deal)
    render(conn, "edit.html", deal: deal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "deal" => deal_params}) do
    deal = Shares.get_deal!(id)

    case Shares.update_deal(deal, deal_params) do
      {:ok, deal} ->
        conn
        |> put_flash(:info, "Deal updated successfully.")
        |> redirect(to: admin_deal_path(conn, :show, deal))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", deal: deal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    deal = Shares.get_deal!(id)
    {:ok, _deal} = Shares.delete_deal(deal)

    conn
    |> put_flash(:info, "Deal deleted successfully.")
    |> redirect(to: admin_deal_path(conn, :index))
  end
end
