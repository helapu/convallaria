defmodule Convallaria.Accounts.VerifyCode do
  use Ecto.Schema
  import Ecto.Changeset


  schema "verify_codes" do
    field :verify_code, :string
    field :type, :string
    field :mobile, :string
    field :status, :string
    field :message, :string

    timestamps()
  end

  @doc false
  def changeset(verify_code, attrs) do
    verify_code
    |> cast(attrs, [:verify_code, :type, :mobile, :status, :message])
    |> validate_required([:verify_code, :type, :mobile])
  end
end
