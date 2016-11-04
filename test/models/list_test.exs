defmodule Simmer.ListTest do
  use Simmer.ModelCase

  test "contacts" do
    contact = Fixtures.create(:contact)
    list    = Fixtures.create(:list)

    SubscriptionManager.subscribe(contact, list)

    assert Repo.preload(list, :contacts).contacts == [contact]
    assert Repo.preload(contact, :lists).lists    == [list]
  end
end
