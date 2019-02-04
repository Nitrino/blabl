defmodule Blabl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :login, :string
    field :phone, :string
    field(:password, :string, virtual: true)
    field :password_hash, :string

    timestamps()
  end

  @required_fields [:login, :email, :password]
  @optional_fields [:phone]
  @attributes @required_fields ++ @optional_fields

  @doc false
  def changeset(owner, attrs) do
    owner
    |> cast(attrs, @attributes)
    |> validate_required(@required_fields)
    |> validate_length(:login, min: 3, max: 255)
    |> validate_length(:password, min: 8, max: 255)
    |> unique_constraint(:email, downcase: true)
    |> unique_constraint(:login, downcase: true)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
