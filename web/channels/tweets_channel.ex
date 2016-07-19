defmodule Nightingale.TweetsChannel do
  use Nightingale.Web, :channel
  import Twitter

  def join("tweets:lobby", payload, socket) do
    if authorized?(payload) do
      send(self, :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    broadcast socket, "tweet", %{text: "I am blah blah blah", author: "splodingsocks", pic: ""}
    broadcast socket, "tweet", %{text: "Two?", author: "splodingsocks", pic: ""}
    {:noreply, socket}
  end

  def broadcast_tweet(tweet) do
    Nightingale.Endpoint.broadcast("tweets:lobby", "tweet", tweet)
  end
  #
  # def handle_out(msg, payload, socket) do
  #   IO.puts "out" <> "#{inspect msg} #{inspect payload}"
  #   {:noreply, socket}
  # end
  #
  # def handle_info(msg, payload, socket) do
  #   IO.puts "info" <> "#{inspect msg} #{inspect payload}"
  #   {:noreply, socket}
  # end
  #
  # def handle_in(msg, payload, socket) do
  #   IO.puts "in" <> "#{inspect msg} #{inspect payload}"
  #   {:noreply, socket}
  # end

  # # It is also common to receive messages from the client and
  # # broadcast to everyone in the current topic (tweets:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast socket, "shout", payload
  #   {:noreply, socket}
  # end

  # # This is invoked every time a notification is being broadcast
  # # to the client. The default implementation is just to push it
  # # downstream but one could filter or change the event.
  # def handle_out(event, payload, socket) do
  #   push socket, event, payload
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end