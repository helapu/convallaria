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
      {:error, :user_exist}
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
            {:error, :register_data_format}
        end

      else
        {:error, :verify_code}
      end

    end

  end

end
