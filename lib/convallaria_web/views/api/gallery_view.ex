defmodule ConvallariaWeb.Api.GalleryView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.GalleryView

  def render("show.json", %{gallery: gallery}) do
    %{gallery: gallery}
  end

end
