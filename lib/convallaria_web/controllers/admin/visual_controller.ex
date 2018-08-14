defmodule ConvallariaWeb.Admin.VisualController do
  use ConvallariaWeb, :controller

  def visual_iot(conn, _params) do
    render(conn, "visual_iot.html")
  end

end