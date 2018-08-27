defmodule ConvallariaWeb.Api.ErrorView do
  use ConvallariaWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end


  # 用户相关错误
  def render("error.json", %{code: :user_not_exist}) do
    %{
      code: 1001,
      message: "用户不存在"
    }
  end

  def render("error.json", %{code: :user_exist}) do
    %{
      code: 1002,
      message: "用户已经存在"
    }
  end

  def render("error.json", %{code: :send_code_failed}) do
    %{
      code: 1003,
      message: "验证码发送错误"
    }
  end

  def render("error.json", %{code: :verify_code_send_to_much}) do
    %{
      code: 1004,
      message: "一分钟最多发送三条验证码"
    }
  end

  def render("error.json", %{code: :register_data_format}) do
    %{
      code: 1005,
      message: "注册信息格式错误,手机号码或者密码格式错误"
    }
  end

  def render("error.json", %{code: :verify_code}) do
    %{
      code: 1006,
      message: "验证码错误"
    }
  end

  def render("error.json", %{code: :user_unactived}) do
    %{
      code: 1007,
      message: "用户处于禁用状态"
    }
  end

  def render("error.json", %{code: :user_password}) do
    %{
      code: 1008,
      message: "用户密码错误"
    }
  end


  # 设备相关错误

  def render("error.json", %{code: :follower_too_much}) do
    %{
      code: 1101,
      message: "一个设备最多可以分享给10个人"
    }
  end



end
