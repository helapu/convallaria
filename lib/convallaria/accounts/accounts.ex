defmodule Convallaria.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Convallaria.Repo

  alias Convallaria.Accounts.User
  

  def register_user(attrs) do
    %User{}
    |> User.register_changeset(attrs)
    |> Repo.insert()
  end

  def mark_as_actived(user) do
    user
    |> User.active_changeset()
    |> Repo.update()

  end
  
  def mark_as_admin(user) do
    user
    |> User.admin_changeset()
    |> Repo.update()
  end

  def get_user_by_mobile(mobile) do
    Repo.get_by(User, mobile: mobile)    
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Convallaria.Accounts.VerifyCode
  

  @doc """
  最近一分钟发送的验证码
  """
  def last_codes(mobile, type) do
    query = from(code in VerifyCode, where: code.mobile == ^mobile and code.type ==  ^type and code.inserted_at >= ago(1, "minute"), select: code, order_by: code.inserted_at)

    # query = from( code in VerifyCode, where: )

    # query = from code in "verify_codes",
    #         where: code.type ==  ^type and code.inserted_at >= ago(1, "minute"),
    #         select: (code.inserted_at, code.mobile, code.type)

    Repo.all(query)
  end

  def last_one_code(mobile, type) do
    query = from(code in VerifyCode, where: code.mobile == ^mobile and code.type ==  ^type and code.inserted_at >= ago(1, "minute"), select: code, order_by: code.inserted_at)

    query |> last(:inserted_at) |> Repo.one
    # query = from( code in VerifyCode, where: )

    # query = from code in "verify_codes",
    #         where: code.type ==  ^type and code.inserted_at >= ago(1, "minute"),
    #         select: (code.inserted_at, code.mobile, code.type)

    # Repo.all(query)
  end

  @doc """
  Returns the list of verify_codes.

  ## Examples

      iex> list_verify_codes()
      [%VerifyCode{}, ...]

  """
  def list_verify_codes do
    Repo.all(VerifyCode)
  end

  @doc """
  Gets a single verify_code.

  Raises `Ecto.NoResultsError` if the Verify code does not exist.

  ## Examples

      iex> get_verify_code!(123)
      %VerifyCode{}

      iex> get_verify_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_verify_code!(id), do: Repo.get!(VerifyCode, id)

  @doc """
  Creates a verify_code.

  ## Examples

      iex> create_verify_code(%{field: value})
      {:ok, %VerifyCode{}}

      iex> create_verify_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_verify_code(attrs \\ %{}) do
    %VerifyCode{}
    |> VerifyCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a verify_code.

  ## Examples

      iex> update_verify_code(verify_code, %{field: new_value})
      {:ok, %VerifyCode{}}

      iex> update_verify_code(verify_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_verify_code(%VerifyCode{} = verify_code, attrs) do
    verify_code
    |> VerifyCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a VerifyCode.

  ## Examples

      iex> delete_verify_code(verify_code)
      {:ok, %VerifyCode{}}

      iex> delete_verify_code(verify_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_verify_code(%VerifyCode{} = verify_code) do
    Repo.delete(verify_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking verify_code changes.

  ## Examples

      iex> change_verify_code(verify_code)
      %Ecto.Changeset{source: %VerifyCode{}}

  """
  def change_verify_code(%VerifyCode{} = verify_code) do
    VerifyCode.changeset(verify_code, %{})
  end
end
