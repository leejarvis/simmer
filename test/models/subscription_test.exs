defmodule Simmer.SubscriptionTest do
  use Simmer.ModelCase

  alias Simmer.Subscription

  test "subscription status defaults to true" do
    assert %Subscription{}.subscribed
  end

  test ".status" do
    assert "Subscribed" == Subscription.status(%Subscription{})
    assert "Unsubscribed" == Subscription.status(%Subscription{subscribed: false})
  end
end
