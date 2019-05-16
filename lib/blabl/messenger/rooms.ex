defmodule Blabl.Messenger.Rooms do
  @moduledoc """
  Context for messenger
  """

  import Ecto.Query, warn: false

  alias Blabl.Repo
  alias Blabl.Schema.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> Blabl.Messenger.Rooms.list_rooms(1)
      [%Room{}, ...]

  """
  def list_rooms(user_id) do
    Repo.all(Room)
  end
end
