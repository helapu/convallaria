defmodule ConvallariaWeb.Plugs.AuthenticatedUser do
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
    if user do
      conn
      |> assign(:current_user, user)
    else
      conn
      |> put_flash(:error, "请先登录")
      |> redirect(to: Helpers.login_path(conn, :login))
      |> halt()
    end
  end
  
end
