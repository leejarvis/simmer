defmodule Simmer.Repo.Migrations.CreateSubscription do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :subscribed, :boolean, default: true, null: false
      add :list_id, references(:lists, on_delete: :nothing)
      add :contact_id, references(:contacts, on_delete: :nothing)

      timestamps()
    end
    create index(:subscriptions, [:list_id, :contact_id], unique: true)

  end
end
