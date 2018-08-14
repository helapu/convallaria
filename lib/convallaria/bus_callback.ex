defmodule Convallaria.BusCallback do

  #removed, no longer supported.
  #def on_publish(data) do
  #	IO.inspect data
  #end

  def on_connect(data) do
    IO.inspect "on_connect"
    IO.inspect data

    topics = ["smoke","b","c"] #list of topics
    qoses = [1,0,2] #list of qos in same order as topics.
    callback_fun = fn(message) ->
      IO.puts message
      IO.puts "on_connect callback_fun"
    end
    #This function will be called when this perticular topic will be subscribed.
    Bus.Mqtt.subscribe(topics,qoses,callback_fun)

  end

  def on_disconnect(data) do
    IO.inspect "on_disconnect"
    IO.inspect data
  end

  def on_error(data) do
    IO.inspect "on_error"
    IO.inspect data
  end

  def on_info(data) do
    IO.inspect "on_info"
    IO.inspect data
  end

  #removed, no longer supported.
  #def on_subscribe(data) do
  #	IO.inspect data
  #end

  #removed, no longer supported.
  #def on_unsubscribe(data) do
  #	IO.inspect data
  #end

  def on_message_received(topic,message) do
    IO.inspect "on_message_received"
    IO.inspect topic
    IO.inspect message
  end

end