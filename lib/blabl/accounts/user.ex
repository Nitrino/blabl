defmodule Blabl.Accounts.User do
  @moduledoc false

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

  @required_fields [:login, :password]
  @optional_fields [:phone, :email]
  @attributes @required_fields ++ @optional_fields

  @doc false
  def changeset(owner, attrs) do
    owner
    |> cast(attrs, @attributes)
    |> validate_required(@required_fields)
    |> validate_length(:login, min: 3, max: 255)
    |> validate_length(:password, min: 8, max: 255)
    |> unique_constraint(:login, downcase: true)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pass))
  end

  defp put_password_hash(changeset), do: changeset
end
