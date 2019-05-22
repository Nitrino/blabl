defmodule Blabl.Schema.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blabl.Schema

  schema "rooms" do
    field :name, :string
    field :topic, :string

    has_many :user_rooms, Schema.UserRoom
    many_to_many :users, Schema.User, join_through: "user_rooms"

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :topic])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
