defmodule ConvallariaWeb.Api.UserView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user, owner: owner}) do
    %{
      data: render_one(user, UserView, "user.json"),
      owner: owner.mobile
    }
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      nickname: user.nickname,
      username: user.username,
      mobile: user.mobile,
      email: user.email,
      encrypted_password: user.encrypted_password,
      last_login: user.last_login,
      is_admin: user.is_admin,
      is_active: user.is_active}
  end
end
