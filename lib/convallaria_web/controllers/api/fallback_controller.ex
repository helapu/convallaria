defmodule ConvallariaWeb.Api.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ConvallariaWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ConvallariaWeb.Api.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ConvallariaWeb.Api.ErrorView, :"404")
  end

  def call(conn, {:error, error_status}) do
    conn
    |> render(ConvallariaWeb.Api.ErrorView, "error.json", code: error_status)
  end

  def call(conn, {:error, :send_code_failed, info}) do
    conn
    |> render(ConvallariaWeb.Api.ErrorView, "error.json", code: :send_code_failed)
  end

end
