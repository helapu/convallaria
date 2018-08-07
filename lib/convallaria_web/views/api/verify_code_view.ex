defmodule ConvallariaWeb.Api.VerifyCodeView do
  use ConvallariaWeb, :view
  alias ConvallariaWeb.Api.VerifyCodeView

  def render("send_code.json", %{expired_at: expired_at}) do
    %{
      code: 201,
      expired_at: expired_at,
      message: "发送成功"
    }
  end

  def render("error.json", %{error: error, code: code}) do
    %{
      code: code,
      error: error
    }
  end
end
