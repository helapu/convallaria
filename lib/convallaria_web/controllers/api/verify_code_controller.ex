defmodule ConvallariaWeb.Api.VerifyCodeController do
  use ConvallariaWeb, :controller

  alias Convallaria.Accounts
  alias Convallaria.Accounts.VerifyCode
  alias Convallaria.Yunpian

  action_fallback ConvallariaWeb.Api.FallbackController

  def send_code(conn, %{"mobile" => mobile, "type" => type}) do
    user = Accounts.get_user_by_mobile(mobile)

    case type do
      # 注册验证码
      "register" ->
        if user do
          # 用户存在 请直接登录
          {:error, :user_exist}
        else
          # 发送注册验证码
          send_by(conn, mobile, type)
        end

      # 忘记密码
      "forgot" ->
        if user do
          # 发送重置验证码
          send_by(conn, mobile, type)
        else
          # 用户不存在 请先注册
          {:error, :user_not_exist}
        end
    end

  end

  defp send_by(conn, mobile, type) do
    codes = Accounts.last_codes(mobile, type)
    if Enum.count(codes) > 3 do
      {:error, :verify_code_send_to_much}
    else
      code = "#{:rand.uniform * 10000 |> round}"
      verify_code_params = %{mobile: mobile, type: type, verify_code: code}

      case Yunpian.send_code(mobile, code) do
        {:ok, %{response_status: sid, message: msg}} ->
          verify_code_params = Map.merge(verify_code_params, %{status: sid, message: msg})

          with {:ok, %VerifyCode{} = verify_code} <- Accounts.create_verify_code(verify_code_params) do
            conn
            |> put_status(:created)
            |> render("send_code.json", expired_at: verify_code.inserted_at)
          end
        {:error, %{response_status: code, message: msg}} ->
          verify_code_params = Map.merge(verify_code_params, %{status: code, message: msg})

          with {:ok, %VerifyCode{} = verify_code} <- Accounts.create_verify_code(verify_code_params) do
            {:error, :send_code_failed}
          end
      end

    end

  end

end
