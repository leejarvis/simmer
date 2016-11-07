defmodule Simmer.Repo.Migrations.CreateAPIKey do
  use Ecto.Migration

  def change do
    create table(:api_keys) do
      add :project_id, references(:projects), null: false

      add :name, :string, null: false
      add :key, :string,  null: false

      timestamps()
    end

    create index(:api_keys, :project_id)
    create index(:api_keys, :name)
    create index(:api_keys, :key)
  end
end
