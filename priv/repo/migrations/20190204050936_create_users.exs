defmodule Blabl.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string, null: false
      add :email, :string, null: false
      add :phone, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
