defmodule Simmer.SubscriptionManagerTest do
  use Simmer.ModelCase

  alias Simmer.SubscriptionManager, as: Manager

  test "subscriptions" do
    list    = Fixtures.create(:list)
    contact = Fixtures.create(:contact)

    refute Manager.subscribed?(contact, list)

    Manager.subscribe(contact, list)
    assert Manager.subscribed?(contact, list)

    # test idempotence and switching args
    Manager.subscribe(contact, list)
    assert Manager.subscribed?(list, contact)

    Manager.unsubscribe(contact, list)
    refute Manager.subscribed?(contact, list)
  end
end
