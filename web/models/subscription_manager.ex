defmodule Simmer.SubscriptionManager do
  alias Simmer.{Repo, Contact, List, Subscription}

  @doc """
  Subscribe a contact to a list. If a previous subscription was not
  found then a new one will be created and automatically subscribed.
  """
  def subscribe(contact = %Contact{}, list = %List{}) do
    case subscription(contact, list) do
      nil -> create_subscription(contact, list)
      subscription -> do_subscribe(subscription)
    end
  end
  def subscribe(list = %List{}, contact = %Contact{}), do: subscribe(contact, list)

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

  @doc """
  Unsubscribe a contact from a list. If a previous subscription was not
  found then a new one will not be created.
  """
  def unsubscribe(contact = %Contact{}, list = %List{}) do
    case subscription(contact, list) do
      nil -> nil
      subscription -> do_unsubscribe(subscription)
    end
  end
  def unsubscribe(list = %List{}, contact = %Contact{}), do: unsubscribe(contact, list)

  defp do_unsubscribe(subscription) do
    if subscription.subscribed do
      Subscription.changeset(subscription, %{subscribed: false})
      |> Repo.update!
    end
  end

  @doc """
  Returns true if this contact is subscribed to the list, false otherwise.
  If a subscription is not found, one will not be created and false will
  be returned
  """
  def subscribed?(contact = %Contact{}, list = %List{}) do
    case subscription(contact, list) do
      nil -> false
      subscription -> subscription.subscribed
    end
  end
  def subscribed?(list = %List{}, contact = %Contact{}), do: subscribed?(contact, list)

  defp subscription(contact, list) do
    Repo.get_by(Subscription, contact_id: contact.id, list_id: list.id)
  end
end
