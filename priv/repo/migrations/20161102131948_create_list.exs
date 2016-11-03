defmodule Simmer.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :name, :string, null: false

      timestamps()
    end

  end
end
