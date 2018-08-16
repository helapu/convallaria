defmodule ConvallariaWeb.Api.GalleryController do
  use ConvallariaWeb, :controller

  alias Convallaria.Image

  action_fallback ConvallariaWeb.FallbackController

  def create(conn, %{"gallery" => gallery_params}) do
    conn
    |> put_status(:created)
    |> render("show.json", gallery: "gallery")
  end

end
