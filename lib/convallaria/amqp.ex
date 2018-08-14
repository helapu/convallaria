defmodule Convallaria.Amqp do
  use GenServer
  use AMQP

  alias Convallaria.Devices
  alias Convallaria.Devices.Product
  
  
  # API

  def post_coap(name) do
    IO.puts "hello coap"
    GenServer.call(:amqp, {:lookup, name})
  end
  
  def start_link do
    GenServer.start_link(__MODULE__, [], name: :amqp)
  end

  @exchange    "lynx.deal"
  @queue       "hello"
  @queue_error "#{@queue}_error"

  def init(_opts) do
    {:ok, conn} = Connection.open("amqp://lynx:lynxiot@localhost")
    {:ok, chan} = Channel.open(conn)
    # Limit unacknowledged messages to 10
    Basic.qos(chan, prefetch_count: 10)
    # Queue.declare(chan, @queue_error, durable: true)
    # # Messages that cannot be delivered to any consumer in the main queue will be routed to the error queue
    # Queue.declare(chan, @queue, durable: true,
    #                             arguments: [{"x-dead-letter-exchange", :longstr, ""},
    #                                         {"x-dead-letter-routing-key", :longstr, @queue_error}])
    # Exchange.fanout(chan, @exchange, durable: true)
    # Queue.bind(chan, @queue, @exchange)

    # Register the GenServer process as a consumer
    {:ok, _consumer_tag} = Basic.consume(chan, @queue)
    {:ok, chan}
  end


  def handle_call({:lookup, name}, _from, chan) do
    {:reply, "callback data", chan}
  end


  # Confirmation sent by the broker after registering this process as a consumer
  def handle_info({:basic_consume_ok, %{consumer_tag: consumer_tag}}, chan) do
    {:noreply, chan}
  end

  # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
  def handle_info({:basic_cancel, %{consumer_tag: consumer_tag}}, chan) do
    {:stop, :normal, chan}
  end

  # Confirmation sent by the broker to the consumer process after a Basic.cancel
  def handle_info({:basic_cancel_ok, %{consumer_tag: consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_deliver, payload, %{delivery_tag: tag, redelivered: redelivered}}, chan) do
    spawn fn -> consume(chan, tag, redelivered, payload) end
    {:noreply, chan}
  end

  defp consume(channel, tag, redelivered, payload) do

    %{"name" => name, "key" => key, "device_type" => device_type, "node_type" => node_type, "secret" => secret} = Poison.Parser.parse! payload
    IO.puts "payload #{payload}"

    u = %{
      "device_type": 1,
      "key": "key",
      "name": "lihai",
      "node_type": 1,
      "secret": "secret"
    }
    case Devices.create_product( u ) do
      {:ok, device} ->
        IO.puts "good #{payload}."
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts "bad #{payload}."
    end

  rescue
    # Requeue unless it's a redelivered message.
    # This means we will retry consuming a message once in case of exception
    # before we give up and have it moved to the error queue
    #
    # You might also want to catch :exit signal in production code.
    # Make sure you call ack, nack or reject otherwise comsumer will stop
    # receiving messages.
    exception ->
      Basic.reject channel, tag, requeue: not redelivered
      IO.puts "Error converting #{payload}"
  end
end