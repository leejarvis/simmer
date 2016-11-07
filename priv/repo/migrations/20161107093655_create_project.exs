defmodule Simmer.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string, null: false

      timestamps()
    end

    create index(:projects, :name, unique: true)
  end
end
