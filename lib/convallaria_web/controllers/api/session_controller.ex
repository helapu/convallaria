defmodule ConvallariaWeb.Api.SessionController do
  use ConvallariaWeb, :controller

  alias Convallaria.Accounts
  alias Convallaria.Accounts.User
  alias Convallaria.Password
  alias Convallaria.Token

  import Logger

  action_fallback ConvallariaWeb.Api.FallbackController

  #登录
  def login(conn, %{"mobile" => mobile, "password" => password}) do
    user = Accounts.get_user_by_mobile(mobile)
    if user do
      if Bcrypt.verify_pass(password, user.encrypted_password) && user.is_active do
        if user.is_active do
          last_login_at = user.last_login_at
          # 标注用户最后登录时间
          Accounts.update_user(user, %{last_login_at: DateTime.utc_now})
          render(conn, "login.json", token: token = Token.generate_token(user), user: user, last_login_at: last_login_at)
        else
          {:error, :user_unactived}
        end
      else
        {:error, :user_password}
      end
    else
      {:error, :user_exist}
    end

  end

  def login(conn, %{"mobile" => mobile, "password" => password}) do
    {:error, :no_matched_request}
  end

end
