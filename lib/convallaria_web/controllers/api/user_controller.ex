defmodule ConvallariaWeb.Api.UserController do
  use ConvallariaWeb, :controller

  alias Convallaria.Accounts
  alias Convallaria.Accounts.User

  action_fallback ConvallariaWeb.FallbackController
  
  def profile(conn, __params) do
    user = current_user(conn)
    render(conn, "profile.json", user: user)

  end

end
