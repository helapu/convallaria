defmodule ConvallariaWeb.Api.SessionController do
  use ConvallariaWeb, :controller

  alias Convallaria.Accounts
  alias Convallaria.Accounts.User
  alias Convallaria.Password
  alias Convallaria.Token

  import Logger
  
  action_fallback ConvallariaWeb.FallbackController

  #登录
  def login(conn, %{"mobile" => mobile, "password" => password}) do
    user = Accounts.get_user_by_mobile(mobile)
    if user do
      if Bcrypt.verify_pass(password, user.encrypted_password) && user.is_active do
        if user.is_active do
          render(conn, "login.json", token: token = Token.generate_token(user), user: user)
        else
          render(conn, "error.json", error: "用户被禁用")
        end
      else
        render(conn, "error.json", error: "密码错误")
      end
    else
      render(conn, "error.json", error: "用户不存在,请先激活")
    end

  end


  def login(conn, params) do
    Logger.info params
    render(conn, "error.json", error: "bad request")
  end

end