defmodule ConvallariaWeb.Admin.SettingController do
  use ConvallariaWeb, :controller

  alias Convallaria.Accounts
  alias Convallaria.Accounts.User

  @intercepted_action ~w(show account password profile reward)a

  def action(conn, _) do
    if Enum.member?(@intercepted_action, action_name(conn)) do
      changeset = Accounts.change_user(current_user(conn))
      render conn, action_name(conn), changeset: changeset
    else
      apply(__MODULE__, action_name(conn), [conn, conn.params])
    end
  end

  def change(conn, %{"user" => user_params}) do
    Logger.info("setting update #{user_params["by"]}")
    case user_params["by"] do
      "show"     ->   update_account(conn, user_params)
      "profile"  ->   update_profile(conn, user_params)
      "password" ->   update_password(conn, user_params)
      "reward"   ->   update_reward(conn, user_params)
    end
  end

  defp update_account(conn, user_params) do
    
  end

  defp update_profile(conn, user_params) do
    
  end

  defp update_password(conn, user_params) do
    case Accounts.update_user_password(current_user(conn), user_params) do
      {:ok, _} ->
        conn
        |> configure_session(drop: true)
        |> put_flash(:info, "User updated password successfully.")
        |> redirect(to: "/login")

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:danger, "Invalid password")
        |> render(:password, changeset: changeset)

      {:error, reason} ->
        changeset = User.update_password_changeset(%User{}, %{})
        conn
        |> put_flash(:danger, reason)
        |> render(:password, changeset: changeset)
    end
  end

  defp update_reward(conn, user_params) do
    
  end

 
end
