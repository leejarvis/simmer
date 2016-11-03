defmodule Simmer.Subscription do
  use Simmer.Web, :model

  alias Simmer.Subscription

  schema "subscriptions" do
    field :subscribed, :boolean, default: true

    belongs_to :list,    Simmer.List
    belongs_to :contact, Simmer.Contact

    timestamps()
  end

  @required_params [:subscribed]
  @optional_params []

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params ++ @optional_params)
    |> validate_required(@required_params)
  end

  def status(%Subscription{subscribed: true}),  do: "Subscribed"
  def status(%Subscription{subscribed: false}), do: "Unsubscribed"
end
