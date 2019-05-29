defmodule Blabl.Messenger do
  @moduledoc """
  Context for messenger
  """

  import Ecto.Query, warn: false

  alias Blabl.Repo
  alias Blabl.Schema.Event
  alias Blabl.Schema.Room
  alias Blabl.Schema.UserRoom

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> Blabl.Messenger.list_rooms(1)
      [%Room{}, ...]

  """
  def list_rooms(user_id) do
    query = from r in Room, join: ur in UserRoom, on: r.id == ur.room_id, where: ur.user_id == ^user_id

    query
    |> Repo.all()
    |> Repo.preload(events: from(e in Event, order_by: [desc: e.inserted_at], limit: 50, preload: :user))
  end

  def list_rooms_map(current_user) do
    case __MODULE__.list_rooms(current_user.id) do
      [] -> %{}
      rooms -> Enum.reduce(rooms, %{}, fn room, acc -> Map.put(acc, room.id, room) end)
    end
  end

  @doc """
  Users count in room
  """
  def room_users_count(room_id) do
    Repo.one(from ur in UserRoom, select: count(ur.id), where: ur.room_id == ^room_id)
  end

  def list_events(room_id, user_id) do
    query = from e in Event, where: e.room_id == ^room_id and e.user_id == ^user_id

    query
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Get a single Room by room_id
  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Create a message
  """
  def create_message(attrs) do
    %Event{}
    |> Event.changeset(Map.put(attrs, "type", "message"))
    |> Repo.insert!()
    |> Repo.preload(:user)
  end

  def change_message do
    Event.changeset(%Event{})
  end

  def subscribe_to_rooms(rooms) do
    Enum.each(rooms, fn room -> BlablWeb.Endpoint.subscribe(topic(room)) end)
  end

  def topic(room) when is_map(room), do: "room:#{room.id}"
  def topic(room_id), do: "room:#{room_id}"
end
