defmodule ConvallariaWeb.Plugs.AuthenticatedApi do
  import Plug.Conn

  alias ConvallariaWeb.Repo
 
  alias Convallaria.Accounts
  alias Convallaria.Accounts.User
  import Phoenix.Controller

  alias ConvallariaWeb.Router.Helpers

  alias Convallaria.Token
  import Logger
  import Convallaria.Token

  def init(_params) do
  end

  def call(conn, _params) do
    cond do
      tokens = Plug.Conn.get_req_header(conn, "token") ->
        Logger.info "token #{tokens}"
        # 验证token
        [token | _tails] = tokens
        case Convallaria.Token.verify_token(token) do
          {:ok, user_id} ->
            case Accounts.get_user!(user_id) do
              user ->
                conn
                |> assign(:current_user, user)
                |> assign(:current_user_id, user.id)
                # |> put_session(:current_user, user)
                # |> put_session(:current_user_id, user.id)
              true ->
                conn
            end
          {:error, __error} ->
            conn
        end
        
      true ->
        # token not exist
        conn
        |> render_unautheried
        |> halt()
    end
  end

  defp render_unautheried(conn) do
    Logger.info "render_unauthenried"
  end
  
end
