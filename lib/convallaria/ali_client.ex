defmodule Convallaria.AliClient do
  import HTTPoison

  # config aliyun iothub
  @access_key "LTAIsOM28rawLJAn"
  @access_secret "yks4wtaotu2BtnHqHe8AOs21zsaOsh"
  @version "2017-04-20" #"2018-01-20"
  @regionid "cn-shanghai"
  @endpoint "iot.cn-shanghai.aliyuncs.com"

  def sync_data(params) do

    timestmap = DateTime.utc_now |> DateTime.truncate(:second) |> DateTime.to_iso8601

    base_params = %{
      "Format" => "JSON",
      "Version" => @version,
      "SignatureMethod" => "HMAC-SHA1",
      "SignatureNonce" => Ecto.UUID.generate,
      "SignatureVersion" => "1.0",
      "AccessKeyId" => @access_key,
      "Timestamp" => timestmap |> String.replace(":", "%3A"),
      "RegionId" => @regionid,
    }
    params = Map.merge(base_params, params)

    IO.puts "Aliyun IotHub API  params:"
    IO.inspect params

    encode_str = URI.encode_query(params)
                  |> String.replace("=", "%3D")
                  |> String.replace("&", "%26")
                  |> String.replace(" ", "%20")

    string_to_sign = "GET&%2F&" <> encode_str
    signature = :crypto.hmac(:sha, @access_secret <> "&", string_to_sign) |> Base.encode64
    signed_params = Map.put(params, "Signature", signature)
    signed_params = %{signed_params | "Timestamp" => timestmap}

    encode_url = URI.encode_query(signed_params)
    IO.puts "https://" <> @endpoint <> "/?" <> encode_url

    case HTTPoison.get("https://" <> @endpoint <> "/?" <> encode_url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body = Poison.decode! body
        IO.inspect body

        case body do
          %{"Success" => true} ->
            IO.puts "Aliyun Get True"
            {:ok, body}
          %{"Success" => false} ->
            IO.puts "Aliyun Get False"
            {:error, body}
          %{"Code" => _code, "Message" => message} ->
            {:error, message}
          _ ->
            {:error, "other errors"}
        end
      
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts "Aliyun Get Some Error"

        {:error, reason}
      _ -> {
        {:error, "not success or error, and catch other errors"}
      }
    end
    
  end
  
  # product
  
  def query_product_list do
    params = %{
      "Action" => "QueryProductList",
      "PageSize" => 12,
      "CurrentPage" => 1,
    }
    r = sync_data(params)
    IO.inspect r
  end

  def create_product do
    params = %{
      "Action" => "CreateProduct",
      "Name" => "justfortest05",
      "NodeType" => 0,
    }
    r = sync_data(params)
    IO.inspect r
  end

  def query_product do
    params = %{
      "Action" => "QueryProduct",
      "ProductKey" => "a1SziBmAhb0",
    }
    r = sync_data(params)
    IO.inspect r
  end

  def update_product do
    params = %{
      "Action" => "UpdateProduct",
      "ProductDesc" => "whatthefuck",
      "ProductKey" => "a1epbMRq2Ch",
      "ProductName" => "iloveyou"
    }
    r = sync_data(params)
    IO.inspect r
  end
  

  # device

  @doc """
  查询指定产品下的所有设备列表
  ["Action", "ProductKey", "PageSize", "CurrentPage"]
  """

  def create_device do
    params = %{
      "Action" => "RegisterDevice",
      "ProductKey" => "a1epbMRq2Ch",
      "DeviceName" => "bobnec",
    }
    r = sync_data(params)
    IO.inspect r
  end

  def query_device do
    params = %{
      "Action" => "QueryDevice",
      "ProductKey" => "a1epbMRq2Ch",
      "PageSize" => 12,
      "CurrentPage" => 1,
    }
    r = sync_data(params)
    IO.inspect r
  end

  # QueryDeviceDetail
  def query_device_detail do
    params = %{
      "Action" => "QueryDeviceDetail",
      "ProductKey" => "a1epbMRq2Ch",
      "DeviceName" => "VETwhQ6TmvlMamUxN7il",
    }
    r = sync_data(params)
    IO.inspect r
  end

  def dump do
    params = %{
      "Action" => "QueryProductList",
      # "ProductKey" => "a1epbMRq2Ch",
      "PageSize" => 12,
      "CurrentPage" => 1,
    }
    r = sync_data(params)
    IO.inspect r
  end

  # topic

  # pub and sub



end