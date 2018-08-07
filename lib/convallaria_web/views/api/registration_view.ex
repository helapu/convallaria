defmodule ConvallariaWeb.Api.RegistrationView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.RegistrationView

  def render("register.json", %{user: user}) do
    %{user: %{
        nickname: user.nickname,
        username: user.username,
        mobile: user.mobile,
        email: user.email,
      },
      code: 201,
      message: "注册成功"
    }
  end

  def render("error.json", %{error: error, code: code}) do
    %{error: error,
      code: code}
  end

end
