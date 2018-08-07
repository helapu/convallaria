defmodule ConvallariaWeb.Api.SessionView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.UserView

  def render("login.json", %{token: token, user: user}) do
    %{token: token,
      user: %{
        nickname: user.nickname,
        username: user.username,
        mobile: user.mobile,
        email: user.email,
      },
      code: 201,
      message: "登录成功"
    }
  end

  def render("error.json", %{error: error}) do
    %{error: error,
      code: 400}
  end

end
