defmodule Obkap.Kafka.Consumer do
  @moduledoc """
  Consumer for kafka events
  """
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module:
          {BroadwayKafka.Producer,
           [
             hosts: [localhost: 9092],
             group_id: "group_1",
             topics: ["test"]
           ]},
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 10
        ]
      ],
      batchers: [
        default: [
          batch_size: 100,
          batch_timeout: 200,
          concurrency: 10
        ]
      ]
    )
  end

  @impl true
  def handle_message(_, %Message{data: raw_data} = message, _)
      when is_binary(raw_data) do
    case Jason.decode(raw_data) do
      {:ok, decoded_data} ->
        message
        |> Message.update_data(fn _ -> decoded_data end)

      _error ->
        Message.failed(message, :json_decode_error)
    end
  end

  @impl true
  def handle_batch(_, messages, _, _) do
    list = messages |> Enum.map(fn e -> e.data end)
    IO.inspect(list, label: "Got batch")
    messages
  end
end
