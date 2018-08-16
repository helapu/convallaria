defmodule ConvallariaWeb.Admin.ShareGalleryController do
  use ConvallariaWeb, :controller

  alias Convallaria.Image
  alias Convallaria.Image.ShareGallery

  def index(conn, _params) do
    share_gallerys = Image.list_share_gallerys()
    render(conn, "index.html", share_gallerys: share_gallerys)
  end

  def new(conn, _params) do
    changeset = Image.change_share_gallery(%ShareGallery{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"share_gallery" => share_gallery_params}) do
    case Image.create_share_gallery(share_gallery_params) do
      {:ok, share_gallery} ->
        conn
        |> put_flash(:info, "Share gallery created successfully.")
        |> redirect(to: admin_share_gallery_path(conn, :show, share_gallery))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    share_gallery = Image.get_share_gallery!(id)
    render(conn, "show.html", share_gallery: share_gallery)
  end

  def edit(conn, %{"id" => id}) do
    share_gallery = Image.get_share_gallery!(id)
    changeset = Image.change_share_gallery(share_gallery)
    render(conn, "edit.html", share_gallery: share_gallery, changeset: changeset)
  end

  def update(conn, %{"id" => id, "share_gallery" => share_gallery_params}) do
    share_gallery = Image.get_share_gallery!(id)

    case Image.update_share_gallery(share_gallery, share_gallery_params) do
      {:ok, share_gallery} ->
        conn
        |> put_flash(:info, "Share gallery updated successfully.")
        |> redirect(to: admin_share_gallery_path(conn, :show, share_gallery))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", share_gallery: share_gallery, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    share_gallery = Image.get_share_gallery!(id)
    {:ok, _share_gallery} = Image.delete_share_gallery(share_gallery)

    conn
    |> put_flash(:info, "Share gallery deleted successfully.")
    |> redirect(to: admin_share_gallery_path(conn, :index))
  end
end
