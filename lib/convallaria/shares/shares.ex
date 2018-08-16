defmodule Convallaria.Shares do
  @moduledoc """
  The Shares context.
  """

  import Ecto.Query, warn: false
  alias Convallaria.Repo

  alias Convallaria.Shares.ExtinguisherItem
  alias Convallaria.Image.ShareGallery

  defmodule ExtinguisherItemGallery do
    defstruct [:item_uuid, :item_name, :item_desc, :share_at,
                :back_at, :charge, :status, :item_id, :item_type]
  end

  @doc """
  extinguisher item gallery
  """
  def get_extinguisher_item_gallery!(id) do
    query = from(image in ShareGallery, where: image.item_type == "ExtinguisherItem", select: image)
    gallerys = Repo.all(query)
  end

  @doc """
  Returns the list of extinguisher_items.

  ## Examples

      iex> list_extinguisher_items()
      [%ExtinguisherItem{}, ...]

  """
  def list_extinguisher_items do
    Repo.all(ExtinguisherItem)
  end

  @doc """
  Gets a single extinguisher_item.

  Raises `Ecto.NoResultsError` if the Extinguisher item does not exist.

  ## Examples

      iex> get_extinguisher_item!(123)
      %ExtinguisherItem{}

      iex> get_extinguisher_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_extinguisher_item!(id), do: Repo.get!(ExtinguisherItem, id)

  @doc """
  Creates a extinguisher_item.

  ## Examples

      iex> create_extinguisher_item(%{field: value})
      {:ok, %ExtinguisherItem{}}

      iex> create_extinguisher_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_extinguisher_item(attrs \\ %{}) do
    %ExtinguisherItem{}
    |> ExtinguisherItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a extinguisher_item.

  ## Examples

      iex> update_extinguisher_item(extinguisher_item, %{field: new_value})
      {:ok, %ExtinguisherItem{}}

      iex> update_extinguisher_item(extinguisher_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_extinguisher_item(%ExtinguisherItem{} = extinguisher_item, attrs) do
    extinguisher_item
    |> ExtinguisherItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ExtinguisherItem.

  ## Examples

      iex> delete_extinguisher_item(extinguisher_item)
      {:ok, %ExtinguisherItem{}}

      iex> delete_extinguisher_item(extinguisher_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_extinguisher_item(%ExtinguisherItem{} = extinguisher_item) do
    Repo.delete(extinguisher_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking extinguisher_item changes.

  ## Examples

      iex> change_extinguisher_item(extinguisher_item)
      %Ecto.Changeset{source: %ExtinguisherItem{}}

  """
  def change_extinguisher_item(%ExtinguisherItem{} = extinguisher_item) do
    ExtinguisherItem.changeset(extinguisher_item, %{})
  end

  alias Convallaria.Shares.Deal


  defmodule DealDetail do
    defstruct [:item_uuid, :item_name, :item_desc, :share_at,
                :back_at, :charge, :status, :item_id, :item_type]
  end

  @doc """
  交易详细信息
  """
  def get_deal_detail!(id) do

    deal = Repo.get!(Deal, id)
    item = Repo.get!(ExtinguisherItem, deal.item_id)
    %DealDetail{item_name: item.name, item_uuid: item.uuid, item_desc: item.desc}
  end

  @doc """
  Returns the list of deals.

  ## Examples

      iex> list_deals()
      [%Deal{}, ...]

  """
  def list_deals do
    Repo.all(Deal)
  end

  @doc """
  Gets a single deal.

  Raises `Ecto.NoResultsError` if the Deal does not exist.

  ## Examples

      iex> get_deal!(123)
      %Deal{}

      iex> get_deal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deal!(id), do: Repo.get!(Deal, id)

  @doc """
  Creates a deal.

  ## Examples

      iex> create_deal(%{field: value})
      {:ok, %Deal{}}

      iex> create_deal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deal(attrs \\ %{}) do
    %Deal{}
    |> Deal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deal.

  ## Examples

      iex> update_deal(deal, %{field: new_value})
      {:ok, %Deal{}}

      iex> update_deal(deal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deal(%Deal{} = deal, attrs) do
    deal
    |> Deal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Deal.

  ## Examples

      iex> delete_deal(deal)
      {:ok, %Deal{}}

      iex> delete_deal(deal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deal(%Deal{} = deal) do
    Repo.delete(deal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deal changes.

  ## Examples

      iex> change_deal(deal)
      %Ecto.Changeset{source: %Deal{}}

  """
  def change_deal(%Deal{} = deal) do
    Deal.changeset(deal, %{})
  end

  
end
