defmodule Convallaria.Token do
  @moduledoc false

  alias Convallaria.Accounts.User
  require Bus

  @verification_salt "Convallaria"

  @endpoint "ibaludobsenudkaeoiukoeaukb"
  
  def generate_token(%User{id: user_id}) do
    Phoenix.Token.sign(@endpoint, @verification_salt, user_id)
    # Phoenix.Token.sign(ConvallariaWeb.Endpoint, @verification_salt, user_id)
  end

  def verify_token(token, expired_seconds \\ 86_400) do
    Phoenix.Token.verify(@endpoint, @verification_salt, token, max_age: expired_seconds)
  end



  def post_mqtt() do
    topic = "smoke/device_name"
    message = "Hello World...!"
    qos = 1
    callback_fun = fn(message) -> IO.puts message end
    Bus.Mqtt.publish(topic,message,callback_fun,qos)


    topics = ["smoke/#","b","c"] #list of topics
    qoses = [1,0,2] #list of qos in same order as topics.
    callback_fun = fn(message) ->
      IO.puts message
      IO.puts "on_connect callback_fun"
    end
    #This function will be called when this perticular topic will be subscribed.
    Bus.Mqtt.subscribe(topics,qoses,callback_fun)
  end
end
