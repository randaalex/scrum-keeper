defmodule ScrumKeeper.Slack.DirectMessagePipeline do
  require Logger

  @commands_dictonary [
    {~r{^status$}, :status},
    {~r{^take\s(?<scrum>scrum\d+)(\son)?\s(?<period>\d+)(\s)?(?<period_type>\w+)$}, :take},
    {~r{^return\s(?<scrum>scrum\d+)$}, :return}
  ]

  def call(message, user) do
    message |> parse |> generate_reply
  end

  defp parse(message) do
    Enum.reduce_while(@commands_dictonary, {}, fn {regex, type}, _ ->
      if match = Regex.named_captures(regex, message) do
        {:halt, {type, atomize_keys(match)}}
      else
        {:cont, {:help, nil}}
      end
    end )
  end

  defp generate_reply({:status, _}) do
    "response: status"
  end

  defp generate_reply({:take, %{scrum: scrum, period: period, period_type: period_type}}) do
    "response: take #{scrum} on #{period} #{period_type}"
  end

  defp generate_reply({:take, %{scrum: scrum}}) do
    "response: take #{scrum} on default period"
  end

  defp generate_reply({:return, %{scrum: scrum}}) do
    "response: return #{scrum}"
  end

  defp generate_reply({_, _}) do
    "response: help"
  end

  defp atomize_keys(map) do
    Map.new(map, fn {k, v} -> {String.to_atom(k), v} end)
  end
end
