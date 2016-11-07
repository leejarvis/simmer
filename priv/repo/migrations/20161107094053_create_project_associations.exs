defmodule Simmer.Repo.Migrations.CreateProjectAssociations do
  use Ecto.Migration

  def change do
    alter table(:lists) do
      add :project_id, references(:projects), null: false
    end
    create index(:lists, :project_id)

    alter table(:contacts) do
      add :project_id, references(:projects), null: false
    end
    create index(:contacts, :project_id)
  end
end
