defmodule Convallaria.Image.ShareGallery do
  use Ecto.Schema
  import Ecto.Changeset


  schema "share_gallerys" do
    field :item_id, :integer
    field :item_type, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(share_gallery, attrs) do
    share_gallery
    |> cast(attrs, [:url, :item_type, :item_id])
    |> validate_required([:url, :item_type, :item_id])
  end
end
