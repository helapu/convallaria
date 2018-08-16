defmodule ConvallariaWeb.Admin.ExtinguisherItemController do
  use ConvallariaWeb, :controller

  alias Convallaria.Shares
  alias Convallaria.Shares.ExtinguisherItem

  def index(conn, _params) do
    extinguisher_items = Shares.list_extinguisher_items()
    render(conn, "index.html", extinguisher_items: extinguisher_items)
  end

  def new(conn, _params) do
    changeset = Shares.change_extinguisher_item(%ExtinguisherItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"extinguisher_item" => extinguisher_item_params}) do
    case Shares.create_extinguisher_item(extinguisher_item_params) do
      {:ok, extinguisher_item} ->
        conn
        |> put_flash(:info, "Extinguisher item created successfully.")
        |> redirect(to: admin_extinguisher_item_path(conn, :show, extinguisher_item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    extinguisher_item = Shares.get_extinguisher_item!(id)
    gallerys = Shares.get_extinguisher_item_gallery!(id)
    render(conn, "show.html", extinguisher_item: extinguisher_item, gallerys: gallerys)
  end

  def edit(conn, %{"id" => id}) do
    extinguisher_item = Shares.get_extinguisher_item!(id)
    changeset = Shares.change_extinguisher_item(extinguisher_item)
    render(conn, "edit.html", extinguisher_item: extinguisher_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "extinguisher_item" => extinguisher_item_params}) do
    extinguisher_item = Shares.get_extinguisher_item!(id)

    case Shares.update_extinguisher_item(extinguisher_item, extinguisher_item_params) do
      {:ok, extinguisher_item} ->
        conn
        |> put_flash(:info, "Extinguisher item updated successfully.")
        |> redirect(to: admin_extinguisher_item_path(conn, :show, extinguisher_item))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", extinguisher_item: extinguisher_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    extinguisher_item = Shares.get_extinguisher_item!(id)
    {:ok, _extinguisher_item} = Shares.delete_extinguisher_item(extinguisher_item)

    conn
    |> put_flash(:info, "Extinguisher item deleted successfully.")
    |> redirect(to: admin_extinguisher_item_path(conn, :index))
  end
end
