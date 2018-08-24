defmodule ConvallariaWeb.Api.UserView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("profile.json", %{user: user}) do
    %{
      data: %{
        nickname: user.nickname,
        username: user.username,
        mobile: user.mobile,
        email: user.email,
        last_login_at: user.last_login_at,
        is_active: user.is_active
      },
      code: 301
    }
  end
end
