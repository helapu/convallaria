defmodule Convallaria.Yunpian do

  @yunpian_key "e5049b80e388951b6a209b702bb1d93d"

  def send_code(mobile, code) do
    expired_time = "1分钟"
    params = %{
      apikey: "e5049b80e388951b6a209b702bb1d93d",
      mobile: mobile,
      text: "【一泰慧安】您的验证码是{#{code}}。有效期为{#{expired_time}}，请尽快验证",
    }

    encode_params = Poison.encode!(params)

    IO.inspect params
    IO.inspect encode_params

    headers = [{"Accept", "application/json"}, {"charset","utf-8"},
               {"Content-Type", "application/x-www-form-urlencoded"}]

    #
    with {:ok, %HTTPoison.Response{body: body}} <- HTTPoison.post("https://sms.yunpian.com/v2/sms/single_send.json", encode_params, headers) do
      IO.inspect body
      body = Poison.decode! body
      case body do
        %{"code" => 0, "sid" => sid, "msg" => msg} ->
          {:ok, %{response_status: sid, message: msg}}
        %{"code" => code, "msg" => msg} ->
          {:error, %{response_status: code, message: msg}}
      end

    end

    # case HTTPoison.post("https://sms.yunpian.com/v2/sms/single_send.json", encode_params, headers) do
    #   {:ok, %HTTPoison.Response{body: body}} ->
    #     IO.inspect body
    #     body = Poison.decode! body

    #     case body do
    #       %{code: 0, sid: sid} ->
    #         {:ok, %{sid: sid}}
    #       %{code: code} ->
    #         {:error, code}
    #     end
    #   {:error, %HTTPoison.Error{reason: reason}} ->
    #     IO.puts "Yunpian Get Some Error"

    #     {:error, "reason"}
    #   _ -> {
    #     {:error, "not success or error, and catch other errors"}
    #   }
    # end
  end

end
