defmodule ConvallariaWeb.Admin.AccountAvatarController do
  use ConvallariaWeb, :controller

  alias Convallaria.Images
  alias Convallaria.Images.AccountAvatar

  def index(conn, _params) do
    account_avatars = Images.list_account_avatars()
    render(conn, "index.html", account_avatars: account_avatars)
  end

  def new(conn, _params) do
    changeset = Images.change_account_avatar(%AccountAvatar{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account_avatar" => account_avatar_params}) do
    case Images.create_account_avatar(account_avatar_params) do
      {:ok, account_avatar} ->
        conn
        |> put_flash(:info, "Account avatar created successfully.")
        |> redirect(to: admin_account_avatar_path(conn, :show, account_avatar))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account_avatar = Images.get_account_avatar!(id)
    render(conn, "show.html", account_avatar: account_avatar)
  end

  def edit(conn, %{"id" => id}) do
    account_avatar = Images.get_account_avatar!(id)
    changeset = Images.change_account_avatar(account_avatar)
    render(conn, "edit.html", account_avatar: account_avatar, changeset: changeset)
  end

  def update(conn, %{"id" => id, "account_avatar" => account_avatar_params}) do
    account_avatar = Images.get_account_avatar!(id)

    case Images.update_account_avatar(account_avatar, account_avatar_params) do
      {:ok, account_avatar} ->
        conn
        |> put_flash(:info, "Account avatar updated successfully.")
        |> redirect(to: admin_account_avatar_path(conn, :show, account_avatar))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", account_avatar: account_avatar, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account_avatar = Images.get_account_avatar!(id)
    {:ok, _account_avatar} = Images.delete_account_avatar(account_avatar)

    conn
    |> put_flash(:info, "Account avatar deleted successfully.")
    |> redirect(to: admin_account_avatar_path(conn, :index))
  end
end
