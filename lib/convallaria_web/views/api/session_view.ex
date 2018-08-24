defmodule ConvallariaWeb.Api.SessionView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.UserView

  def render("login.json", %{token: token, user: user, last_login_at: last_login_at}) do
    %{
      data: %{
        user: %{
          nickname: user.nickname,
          username: user.username,
          mobile: user.mobile,
          email: user.email,
          last_login_at: last_login_at
        },
        token: token
      },
      code: 201,
    }
  end

  def render("error.json", %{error: error}) do
    %{error: error,
      code: 400}
  end

end
