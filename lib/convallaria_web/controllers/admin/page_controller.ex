defmodule ConvallariaWeb.Admin.PageController do
  use ConvallariaWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
