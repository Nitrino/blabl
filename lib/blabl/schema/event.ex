defmodule Blabl.Schema.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blabl.Schema

  schema "events" do
    field :text, :string
    field :type, :string

    belongs_to :room, Schema.Room
    belongs_to :user, Schema.User

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:text, :user_id, :room_id, :type])
    |> validate_required([:user_id, :room_id, :type])
  end
end
