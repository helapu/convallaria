defmodule Convallaria.AccountsTest do
  use Convallaria.DataCase

  alias Convallaria.Accounts

  describe "users" do
    alias Convallaria.Accounts.User

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password", is_active: true, is_admin: true, last_login: "2010-04-17 14:00:00.000000Z", mobile: "some mobile", nickname: "some nickname", username: "some username"}
    @update_attrs %{email: "some updated email", encrypted_password: "some updated encrypted_password", is_active: false, is_admin: false, last_login: "2011-05-18 15:01:01.000000Z", mobile: "some updated mobile", nickname: "some updated nickname", username: "some updated username"}
    @invalid_attrs %{email: nil, encrypted_password: nil, is_active: nil, is_admin: nil, last_login: nil, mobile: nil, nickname: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.encrypted_password == "some encrypted_password"
      assert user.is_active == true
      assert user.is_admin == true
      assert user.last_login == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert user.mobile == "some mobile"
      assert user.nickname == "some nickname"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.encrypted_password == "some updated encrypted_password"
      assert user.is_active == false
      assert user.is_admin == false
      assert user.last_login == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert user.mobile == "some updated mobile"
      assert user.nickname == "some updated nickname"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "verification_codes" do
    alias Convallaria.Accounts.VerificationCode

    @valid_attrs %{code: "some code", mobile: "some mobile", type: "some type"}
    @update_attrs %{code: "some updated code", mobile: "some updated mobile", type: "some updated type"}
    @invalid_attrs %{code: nil, mobile: nil, type: nil}

    def verification_code_fixture(attrs \\ %{}) do
      {:ok, verification_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_verification_code()

      verification_code
    end

    test "list_verification_codes/0 returns all verification_codes" do
      verification_code = verification_code_fixture()
      assert Accounts.list_verification_codes() == [verification_code]
    end

    test "get_verification_code!/1 returns the verification_code with given id" do
      verification_code = verification_code_fixture()
      assert Accounts.get_verification_code!(verification_code.id) == verification_code
    end

    test "create_verification_code/1 with valid data creates a verification_code" do
      assert {:ok, %VerificationCode{} = verification_code} = Accounts.create_verification_code(@valid_attrs)
      assert verification_code.code == "some code"
      assert verification_code.mobile == "some mobile"
      assert verification_code.type == "some type"
    end

    test "create_verification_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_verification_code(@invalid_attrs)
    end

    test "update_verification_code/2 with valid data updates the verification_code" do
      verification_code = verification_code_fixture()
      assert {:ok, verification_code} = Accounts.update_verification_code(verification_code, @update_attrs)
      assert %VerificationCode{} = verification_code
      assert verification_code.code == "some updated code"
      assert verification_code.mobile == "some updated mobile"
      assert verification_code.type == "some updated type"
    end

    test "update_verification_code/2 with invalid data returns error changeset" do
      verification_code = verification_code_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_verification_code(verification_code, @invalid_attrs)
      assert verification_code == Accounts.get_verification_code!(verification_code.id)
    end

    test "delete_verification_code/1 deletes the verification_code" do
      verification_code = verification_code_fixture()
      assert {:ok, %VerificationCode{}} = Accounts.delete_verification_code(verification_code)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_verification_code!(verification_code.id) end
    end

    test "change_verification_code/1 returns a verification_code changeset" do
      verification_code = verification_code_fixture()
      assert %Ecto.Changeset{} = Accounts.change_verification_code(verification_code)
    end
  end

  describe "verify_codes" do
    alias Convallaria.Accounts.VerifyCode

    @valid_attrs %{code: "some code", mobile: "some mobile", type: "some type"}
    @update_attrs %{code: "some updated code", mobile: "some updated mobile", type: "some updated type"}
    @invalid_attrs %{code: nil, mobile: nil, type: nil}

    def verify_code_fixture(attrs \\ %{}) do
      {:ok, verify_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_verify_code()

      verify_code
    end

    test "list_verify_codes/0 returns all verify_codes" do
      verify_code = verify_code_fixture()
      assert Accounts.list_verify_codes() == [verify_code]
    end

    test "get_verify_code!/1 returns the verify_code with given id" do
      verify_code = verify_code_fixture()
      assert Accounts.get_verify_code!(verify_code.id) == verify_code
    end

    test "create_verify_code/1 with valid data creates a verify_code" do
      assert {:ok, %VerifyCode{} = verify_code} = Accounts.create_verify_code(@valid_attrs)
      assert verify_code.code == "some code"
      assert verify_code.mobile == "some mobile"
      assert verify_code.type == "some type"
    end

    test "create_verify_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_verify_code(@invalid_attrs)
    end

    test "update_verify_code/2 with valid data updates the verify_code" do
      verify_code = verify_code_fixture()
      assert {:ok, verify_code} = Accounts.update_verify_code(verify_code, @update_attrs)
      assert %VerifyCode{} = verify_code
      assert verify_code.code == "some updated code"
      assert verify_code.mobile == "some updated mobile"
      assert verify_code.type == "some updated type"
    end

    test "update_verify_code/2 with invalid data returns error changeset" do
      verify_code = verify_code_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_verify_code(verify_code, @invalid_attrs)
      assert verify_code == Accounts.get_verify_code!(verify_code.id)
    end

    test "delete_verify_code/1 deletes the verify_code" do
      verify_code = verify_code_fixture()
      assert {:ok, %VerifyCode{}} = Accounts.delete_verify_code(verify_code)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_verify_code!(verify_code.id) end
    end

    test "change_verify_code/1 returns a verify_code changeset" do
      verify_code = verify_code_fixture()
      assert %Ecto.Changeset{} = Accounts.change_verify_code(verify_code)
    end
  end
end
