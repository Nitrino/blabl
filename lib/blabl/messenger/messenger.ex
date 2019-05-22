defmodule Blabl.Messenger do
  @moduledoc """
  Context for messenger
  """

  import Ecto.Query, warn: false

  alias Blabl.Repo
  alias Blabl.Schema.Event
  alias Blabl.Schema.Room
  alias Blabl.Schema.UserRoom
  alias Blabl.Schema.User

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> Blabl.Messenger.list_rooms(1)
      [%Room{}, ...]

  """
  def list_rooms(user_id) do
    query = from r in Room, join: ur in UserRoom, on: r.id == ur.room_id, where: ur.user_id == ^user_id
    Repo.all(query)
  end

  def list_events(room_id, user_id) do
    query = from e in Event, where: e.room_id == ^room_id and e.user_id == ^user_id
    query
    |> Repo.all
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
    |> Event.changeset(Map.put(attrs, :type, "message"))
    |> Repo.insert!
    |> Repo.preload(:user)
  end
end
