defmodule Blabl.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :text, :string
      add :type, :string
      add :room_id, references(:rooms, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:events, [:room_id])
    create index(:events, [:user_id])
  end
end
