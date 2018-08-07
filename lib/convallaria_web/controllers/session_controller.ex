defmodule ConvallariaWeb.SessionController do
  use ConvallariaWeb, :controller

  alias Convallaria.Accounts
  alias Convallaria.Accounts.User
  alias Convallaria.Password
  alias Convallaria.Repo
  alias Convallaria.{
    Token,
    Mailer,
    Email
  }
  
  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  #登录
  def login(conn, %{"user" => user_params}) do
    user = Accounts.get_user_by_mobile(user_params["mobile"])
    
    if user do

      if Bcrypt.verify_pass(user_params["password"], user.encrypted_password) do
        if user.is_active do
          if user.is_admin do
            conn
            |> put_session(:current_user, user)
            |> put_session(:current_user_id, user.id)
            |> put_flash(:info, 'You are now signed in.')
            |> redirect(to: admin_page_path(conn, :index))
          else
            conn
            |> put_session(:current_user, user)
            |> put_session(:current_user_id, user.id)
            |> put_flash(:info, 'You are now signed in.')
            |> redirect(to: user_path(conn, :dashboard))
          end
        else
          conn
          |> put_flash(:error, '用户未激活')
          |> render("new.html", changeset: Accounts.change_user(%User{}) )
        end
      else
        conn
        |> put_flash(:error, 'Username or password are incorrect.')
        |> render("new.html", changeset: Accounts.change_user(%User{}) )
      end

    else
      conn
      |> put_flash(:error, "用户不存在")
      |> render("new.html", changeset: Accounts.change_user(%User{}) )
    end

  end

  #退出
  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> delete_session(:current_user_id)
    |> put_flash(:info, 'You have been logged out')
    |> redirect(to: session_path(conn, :new))

  end

  
end
