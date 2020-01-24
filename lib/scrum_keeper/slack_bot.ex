defmodule ScrumKeeper.SlackBot do
  use Slack

  require Logger

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    bot_id = slack.me.id
    bot_id_size = byte_size(bot_id)

    Logger.debug "Handling message: #{inspect(message.text)}"

    case message do
      # direct message
      %{channel: "D" <> _, text: command} ->
        Logger.debug("direct mess, #{command}")
        Slack.DirectMessageHandler.call(command)
      # channel mess with mention
      %{text: <<"<@", _ :: binary-size(bot_id_size), "> ", command::binary>>} ->
        Logger.debug("chann mess from #{message.user}, #{command}")
        Slack.ChannelMessageHandler.call(command, message.user)
      _ ->
        Logger.debug("lol kek")
    end

    # IO.puts "Handle message: #{message.text}"
    # Slack.ResponseBuilder.call(message, slack)
    # send_message("I got a message!", message.channel, slack)

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
