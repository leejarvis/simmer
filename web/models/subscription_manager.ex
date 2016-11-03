defmodule Simmer.SubscriptionManager do
  alias Simmer.{Repo, Contact, List, Subscription}

  def subscribe(contact = %Contact{}, list = %List{}) do
    case subscription(contact, list) do
      nil -> create_subscription(contact, list)
      subscription -> do_subscribe(subscription)
    end
  end

  defp do_subscribe(subscription) do
    unless subscription.subscribed do
      Subscription.changeset(subscription, %{subscribed: true})
      |> Repo.update!
    end
  end

  defp create_subscription(contact, list) do
    Subscription.changeset(%Subscription{})
    |> Ecto.Changeset.put_assoc(:contact, contact)
    |> Ecto.Changeset.put_assoc(:list, list)
    |> Repo.insert!
  end

  def unsubscribe(contact = %Contact{}, list = %List{}) do
    case subscription(contact, list) do
      nil -> nil
      subscription -> do_unsubscribe(subscription)
    end
  end

  defp do_unsubscribe(subscription) do
    if subscription.subscribed do
      Subscription.changeset(subscription, %{subscribed: false})
      |> Repo.update!
    end
  end

  def subscribed?(contact = %Contact{}, list = %List{}) do
    case subscription(contact, list) do
      nil -> false
      subscription -> subscription.subscribed
    end
  end

  defp subscription(contact, list) do
    Repo.get_by(Subscription, contact_id: contact.id, list_id: list.id)
  end
end
