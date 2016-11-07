defmodule Simmer.ListTest do
  use Simmer.ModelCase

  test "contacts" do
    project = Fixtures.project
    contact = Fixtures.create(project, :contact)
    list    = Fixtures.create(project, :list)

    SubscriptionManager.subscribe(contact, list)

    assert Repo.preload(list, :contacts).contacts == [contact]
    assert Repo.preload(contact, :lists).lists    == [list]
  end
end
