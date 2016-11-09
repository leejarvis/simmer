defmodule Simmer.ContactTest do
  use Simmer.ModelCase

  alias Simmer.Contact

  setup _tags do
    project = Fixtures.project()
    contact = Fixtures.create(project, :contact)
    contact = Repo.preload(contact, :project)

    {:ok, project: project, contact: contact}
  end

  test "additional_fields", %{project: project, contact: contact} do
    assert %{} == contact.additional_fields

    fields    = %{"foo" => "bar"}
    changeset = Contact.changeset(contact, project, %{additional_fields: fields})
    assert changeset.valid?

    fields    = for n <- 1..30, do: {"#{n}_key", "#{n}_value"}, into: %{}
    changeset = Contact.changeset(contact, project, %{additional_fields: fields})
    assert {:additional_fields, "cannot be more than 20"} in errors_on(changeset)
  end
end
