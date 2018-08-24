defmodule Convallaria.Images do
  @moduledoc """
  The Images context.
  """

  import Ecto.Query, warn: false
  alias Convallaria.Repo

  alias Convallaria.Images.AccountAvatar

  @doc """
  Returns the list of account_avatars.

  ## Examples

      iex> list_account_avatars()
      [%AccountAvatar{}, ...]

  """
  def list_account_avatars do
    Repo.all(AccountAvatar)
  end

  @doc """
  Gets a single account_avatar.

  Raises `Ecto.NoResultsError` if the Account avatar does not exist.

  ## Examples

      iex> get_account_avatar!(123)
      %AccountAvatar{}

      iex> get_account_avatar!(456)
      ** (Ecto.NoResultsError)

  """
  def get_account_avatar!(id), do: Repo.get!(AccountAvatar, id)

  @doc """
  Creates a account_avatar.

  ## Examples

      iex> create_account_avatar(%{field: value})
      {:ok, %AccountAvatar{}}

      iex> create_account_avatar(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_account_avatar(attrs \\ %{}) do
    %AccountAvatar{}
    |> AccountAvatar.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a account_avatar.

  ## Examples

      iex> update_account_avatar(account_avatar, %{field: new_value})
      {:ok, %AccountAvatar{}}

      iex> update_account_avatar(account_avatar, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_account_avatar(%AccountAvatar{} = account_avatar, attrs) do
    account_avatar
    |> AccountAvatar.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a AccountAvatar.

  ## Examples

      iex> delete_account_avatar(account_avatar)
      {:ok, %AccountAvatar{}}

      iex> delete_account_avatar(account_avatar)
      {:error, %Ecto.Changeset{}}

  """
  def delete_account_avatar(%AccountAvatar{} = account_avatar) do
    Repo.delete(account_avatar)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking account_avatar changes.

  ## Examples

      iex> change_account_avatar(account_avatar)
      %Ecto.Changeset{source: %AccountAvatar{}}

  """
  def change_account_avatar(%AccountAvatar{} = account_avatar) do
    AccountAvatar.changeset(account_avatar, %{})
  end
end
