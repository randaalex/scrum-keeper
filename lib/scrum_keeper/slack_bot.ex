defmodule ScrumKeeper.SlackBot do
  use Slack

  alias ScrumKeeper.Slack.{DirectMessagePipeline, ChannelMessagePipeline}

  require Logger

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    bot_id = slack.me.id
    bot_id_size = byte_size(bot_id)

    Logger.debug "Handling message: #{inspect(message.text)}"

    response =
      case message do
        %{channel: "D" <> _, text: text} ->
          # handle_direct_message(text, message, slack)
          DirectMessagePipeline.call(text, message.user)
        %{text: <<"<@", _ :: binary-size(bot_id_size), "> ", text::binary>>} ->
          # handle_channel_message(text, message, slack)
          ChannelMessagePipeline.call(text, message.user)
        _ -> nil
      end

    if response do
      send_message(response, message.channel, slack)
    end

    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    IO.puts "Sending your message, captain!"

    send_message(text, channel, slack)

    {:ok, state}
  end
  def handle_info(_, _, state), do: {:ok, state}
end
