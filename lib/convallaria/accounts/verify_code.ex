defmodule Convallaria.Accounts.VerifyCode do
  use Ecto.Schema
  import Ecto.Changeset


  schema "verify_codes" do
    field :code, :string
    field :mobile, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(verify_code, attrs) do
    verify_code
    |> cast(attrs, [:code, :type, :mobile])
    |> validate_required([:code, :type, :mobile])
  end
end
