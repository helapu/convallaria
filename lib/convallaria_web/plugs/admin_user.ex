
defmodule ConvallariaWeb.Plugs.AdminUser do
  import Plug.Conn

  alias ConvallariaWeb.Repo
 
  alias Convallaria.Accounts
  alias Convallaria.Accounts.User
  import Phoenix.Controller

  alias ConvallariaWeb.Router.Helpers

  import ConvallariaWeb.Session, only: [current_user: 1]

  def init(_params) do
  end

  def call(conn, _params) do
    user = current_user(conn)
    if user.is_admin do
      conn
      |> assign(:current_user, user)
    else
      conn
      |> put_flash(:error, "您不是超级管理员")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
  
end
