defmodule Simmer.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :email, :string, null: false
      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

    create index(:contacts, :email)
  end
end
