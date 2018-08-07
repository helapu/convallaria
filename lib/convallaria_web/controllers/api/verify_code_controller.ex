defmodule ConvallariaWeb.Api.VerifyCodeController do
  use ConvallariaWeb, :controller

  alias Convallaria.Accounts
  alias Convallaria.Accounts.VerifyCode
    
  def send_code(conn, %{"mobile" => mobile, "type" => type}) do
    user = Accounts.get_user_by_mobile(mobile)

    case type do
      # 注册验证码
      "register" ->
        if user do
          # 用户存在 请直接登录
          render(conn, "error.json", error: "用户存在请直接登录", code: 1002)
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
          render(conn, "error.json", error: "用户不存在请先注册", code: 1001)
        end
    end
    
  end

  defp send_by(conn, mobile, type) do
    codes = Accounts.last_codes(mobile, type)
    if Enum.count(codes) > 3 do
      render(conn, "error.json", error: "一分钟最多发送三条#{type}验证码", code: 1005)
    else
      code = "#{:rand.uniform * 10000 |> round}"
      verify_code_params = %{mobile: mobile, type: type, code: code}
  
      with {:ok, %VerifyCode{} = verify_code} <- Accounts.create_verify_code(verify_code_params) do
        conn
        |> put_status(:created)
        |> render("send_code.json", expired_at: verify_code.inserted_at)
      end
  
    end
    
  end

end
