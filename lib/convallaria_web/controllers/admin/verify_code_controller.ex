defmodule ConvallariaWeb.Admin.VerifyCodeController do
  use ConvallariaWeb, :controller

  alias Convallaria.Accounts
  alias Convallaria.Accounts.VerifyCode

  def index(conn, _params) do
    verify_codes = Accounts.list_verify_codes()
    render(conn, "index.html", verify_codes: verify_codes)
  end

  def new(conn, _params) do
    changeset = Accounts.change_verify_code(%VerifyCode{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"verify_code" => verify_code_params}) do
    case Accounts.create_verify_code(verify_code_params) do
      {:ok, verify_code} ->
        conn
        |> put_flash(:info, "Verify code created successfully.")
        |> redirect(to: admin_verify_code_path(conn, :show, verify_code))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    verify_code = Accounts.get_verify_code!(id)
    render(conn, "show.html", verify_code: verify_code)
  end

  def edit(conn, %{"id" => id}) do
    verify_code = Accounts.get_verify_code!(id)
    changeset = Accounts.change_verify_code(verify_code)
    render(conn, "edit.html", verify_code: verify_code, changeset: changeset)
  end

  def update(conn, %{"id" => id, "verify_code" => verify_code_params}) do
    verify_code = Accounts.get_verify_code!(id)

    case Accounts.update_verify_code(verify_code, verify_code_params) do
      {:ok, verify_code} ->
        conn
        |> put_flash(:info, "Verify code updated successfully.")
        |> redirect(to: admin_verify_code_path(conn, :show, verify_code))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", verify_code: verify_code, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    verify_code = Accounts.get_verify_code!(id)
    {:ok, _verify_code} = Accounts.delete_verify_code(verify_code)

    conn
    |> put_flash(:info, "Verify code deleted successfully.")
    |> redirect(to: admin_verify_code_path(conn, :index))
  end
end
