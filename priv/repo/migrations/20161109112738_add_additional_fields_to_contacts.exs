defmodule Simmer.Repo.Migrations.AddAdditionalFieldsToContacts do
  use Ecto.Migration

  def change do
    alter table(:contacts) do
      add :additional_fields, :map, null: false
    end
  end
end
