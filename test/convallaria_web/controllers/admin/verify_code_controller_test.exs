defmodule ConvallariaWeb.Admin.VerifyCodeControllerTest do
  use ConvallariaWeb.ConnCase

  alias Convallaria.Accounts

  @create_attrs %{code: "some code", mobile: "some mobile", type: "some type"}
  @update_attrs %{code: "some updated code", mobile: "some updated mobile", type: "some updated type"}
  @invalid_attrs %{code: nil, mobile: nil, type: nil}

  def fixture(:verify_code) do
    {:ok, verify_code} = Accounts.create_verify_code(@create_attrs)
    verify_code
  end

  describe "index" do
    test "lists all verify_codes", %{conn: conn} do
      conn = get conn, admin_verify_code_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Verify codes"
    end
  end

  describe "new verify_code" do
    test "renders form", %{conn: conn} do
      conn = get conn, admin_verify_code_path(conn, :new)
      assert html_response(conn, 200) =~ "New Verify code"
    end
  end

  describe "create verify_code" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, admin_verify_code_path(conn, :create), verify_code: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == admin_verify_code_path(conn, :show, id)

      conn = get conn, admin_verify_code_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Verify code"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, admin_verify_code_path(conn, :create), verify_code: @invalid_attrs
      assert html_response(conn, 200) =~ "New Verify code"
    end
  end

  describe "edit verify_code" do
    setup [:create_verify_code]

    test "renders form for editing chosen verify_code", %{conn: conn, verify_code: verify_code} do
      conn = get conn, admin_verify_code_path(conn, :edit, verify_code)
      assert html_response(conn, 200) =~ "Edit Verify code"
    end
  end

  describe "update verify_code" do
    setup [:create_verify_code]

    test "redirects when data is valid", %{conn: conn, verify_code: verify_code} do
      conn = put conn, admin_verify_code_path(conn, :update, verify_code), verify_code: @update_attrs
      assert redirected_to(conn) == admin_verify_code_path(conn, :show, verify_code)

      conn = get conn, admin_verify_code_path(conn, :show, verify_code)
      assert html_response(conn, 200) =~ "some updated code"
    end

    test "renders errors when data is invalid", %{conn: conn, verify_code: verify_code} do
      conn = put conn, admin_verify_code_path(conn, :update, verify_code), verify_code: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Verify code"
    end
  end

  describe "delete verify_code" do
    setup [:create_verify_code]

    test "deletes chosen verify_code", %{conn: conn, verify_code: verify_code} do
      conn = delete conn, admin_verify_code_path(conn, :delete, verify_code)
      assert redirected_to(conn) == admin_verify_code_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, admin_verify_code_path(conn, :show, verify_code)
      end
    end
  end

  defp create_verify_code(_) do
    verify_code = fixture(:verify_code)
    {:ok, verify_code: verify_code}
  end
end
