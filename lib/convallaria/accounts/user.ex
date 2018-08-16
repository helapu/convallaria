defmodule Convallaria.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :is_active, :boolean, default: false
    field :is_admin, :boolean, default: false
    field :last_login_at, :utc_datetime
    field :mobile, :string
    field :nickname, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :sms_code, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nickname, :username, :mobile, :email, :last_login_at])
    |> validate_required([:mobile])
  end

  @doc """
  Change user password.
  """
  def update_password_changeset(user, attrs) do
    required_attrs = ~w(
      password
      password_confirmation
    )a

    user
    |> cast(attrs, required_attrs)
    |> validate_required(required_attrs)
    |> validate_confirmation(:password)
    |> put_pass_hash
  end

  @doc false
  def register_changeset(user, attrs) do
    permitted_attrs = ~w(
      username
      mobile
      email
      password
      password_confirmation
    )a

    register_attrs = ~w(
      mobile
      password
      password_confirmation
    )a

    user
    |> cast(attrs, permitted_attrs)
    |> validate_required(register_attrs)
    |> validate_length(:mobile, min: 11, max: 11)
    |> unique_constraint(:mobile)
    |> unique_constraint(:email)
    |> validate_confirmation(:password)
    |> validate_length(:password, min: 6, max: 18)
    |> put_pass_hash()
  end

  def login_changeset(user, attrs) do
    login_attrs = ~w(
      mobile
      password
    )a

    user
    |> cast(attrs, login_attrs)
    |> validate_required(login_attrs)
  end

  @doc false
  def active_changeset(user) do
    user
    |> Ecto.Changeset.change(%{is_active: true})
  end

  @doc false
  def admin_changeset(user) do
    user
    |> Ecto.Changeset.change(%{is_admin: true})
  end


  defp validate_password_strong(changeset) do
    password = get_change(changeset, :password)
    # checek
    if true do
      changeset
    else
      changeset
      |> add_error(:password, "密码需要包含数字和字符")
    end
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :encrypted_password, Bcrypt.hash_pwd_salt(password))
      _ ->
        changeset
    end
  end

end
