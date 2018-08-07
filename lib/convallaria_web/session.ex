defmodule ConvallariaWeb.Session do
  @moduledoc """
  Some helpers for session-related things
  """

  alias Convallaria.Accounts
  alias Plug.Conn

  def current_user(%{assigns: %{current_user: u}}), do: u

  def current_user(conn) do
    case get_current_user(conn) do
      nil ->
        nil
      user_id  ->
        Accounts.get_user!(user_id)
    end
  end

  # def user_logged_in?(conn), do: current_user(conn)

  # def admin?(conn) do
  #   case current_user(conn) do
  #     nil -> false
  #     u   -> u.is_admin
  #   end
  # end

  defp get_current_user(conn) do
    if get_session_from_cookies() do
      case conn.cookies["current_user_id"] do
        nil -> Conn.get_session(conn, :current_user_id)
        user_id  -> user_id
      end
    else
      Conn.get_session(conn, :current_user_id)
    end
  end

  defp get_session_from_cookies do
    Application.get_env(:ConvallariaWeb, :get_session_from_cookies) || false
  end
end
