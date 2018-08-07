defmodule ConvallariaWeb.Api.RegistrationController do
  use ConvallariaWeb, :controller


  alias Convallaria.Accounts
  alias Convallaria.Accounts.User
  alias Convallaria.Password
  alias Convallaria.Token

  import Logger

  action_fallback ConvallariaWeb.FallbackController

  def register(conn, %{"mobile" => mobile, "password" => password, "sms_code" => sms_code}) do

    user = Accounts.get_user_by_mobile(mobile)

    if user do
      render(conn, "error.json", error: "用户已经存在", code: 1002)
    else
      Logger.info "start register user"
      last_code = Accounts.last_one_code(mobile, "register")
      if last_code && last_code.code == sms_code do
        Logger.info "last code is: #{last_code.code}"

        data = %{
          "mobile" => mobile,
          "password" => password,
          "password_confirmation" => password,
        }
        case Accounts.register_user(data) do
          {:ok, u0} ->
            Accounts.mark_as_actived(u0)
            render(conn, "register.json", user: u0)
          {:error, _changeset} ->
            render(conn, "error.json", error: "注册信息错误", code: 1008)
        end
        
      else
        render(conn, "error.json", error: "验证码错误", code: 1007)
      end

    end

  end

end
