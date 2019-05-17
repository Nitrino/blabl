defmodule Blabl.Messenger do
  @moduledoc """
  Context for messenger
  """

  import Ecto.Query, warn: false

  alias Blabl.Repo
  alias Blabl.Schema.Room
  alias Blabl.Schema.Event

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> Blabl.Messenger.list_rooms(1)
      [%Room{}, ...]

  """
  def list_rooms(user_id) do
    Repo.all(Room)
  end

  def list_events(room_id, user_id) do
    Repo.all(from e in Event, where: e.room_id == ^room_id and e.user_id == ^user_id)
  end
end
