defmodule BlablWeb.MessengerView do
  use BlablWeb, :view

  alias Blabl.Messenger

  def initials(name) do
    name
    |> String.slice(0..1)
    |> String.upcase()
  end

  def room_last_event_time(room) do
    room.events |> List.first |> event_time()
  end

  def event_time(nil), do: ""
  def event_time(event), do: Timex.format!(event.inserted_at, "%H:%M", :strftime)

  def room_users_count(room), do: Messenger.room_users_count(room.id)
end
