defmodule Convallaria.Image do
  @moduledoc """
  The Image context.
  """

  import Ecto.Query, warn: false
  alias Convallaria.Repo

  alias Convallaria.Image.ShareGallery
  
  @doc """
  Returns the list of share_gallerys.

  ## Examples

      iex> list_share_gallerys()
      [%ShareGallery{}, ...]

  """
  def list_share_gallerys do
    Repo.all(ShareGallery)
  end

  @doc """
  Gets a single share_gallery.

  Raises `Ecto.NoResultsError` if the Share gallery does not exist.

  ## Examples

      iex> get_share_gallery!(123)
      %ShareGallery{}

      iex> get_share_gallery!(456)
      ** (Ecto.NoResultsError)

  """
  def get_share_gallery!(id), do: Repo.get!(ShareGallery, id)

  @doc """
  Creates a share_gallery.

  ## Examples

      iex> create_share_gallery(%{field: value})
      {:ok, %ShareGallery{}}

      iex> create_share_gallery(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_share_gallery(attrs \\ %{}) do
    %ShareGallery{}
    |> ShareGallery.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a share_gallery.

  ## Examples

      iex> update_share_gallery(share_gallery, %{field: new_value})
      {:ok, %ShareGallery{}}

      iex> update_share_gallery(share_gallery, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_share_gallery(%ShareGallery{} = share_gallery, attrs) do
    share_gallery
    |> ShareGallery.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ShareGallery.

  ## Examples

      iex> delete_share_gallery(share_gallery)
      {:ok, %ShareGallery{}}

      iex> delete_share_gallery(share_gallery)
      {:error, %Ecto.Changeset{}}

  """
  def delete_share_gallery(%ShareGallery{} = share_gallery) do
    Repo.delete(share_gallery)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking share_gallery changes.

  ## Examples

      iex> change_share_gallery(share_gallery)
      %Ecto.Changeset{source: %ShareGallery{}}

  """
  def change_share_gallery(%ShareGallery{} = share_gallery) do
    ShareGallery.changeset(share_gallery, %{})
  end

  alias Convallaria.Image.AccountAvatar

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
