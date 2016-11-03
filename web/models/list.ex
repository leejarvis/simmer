defmodule Simmer.List do
  use Simmer.Web, :model

  schema "lists" do
    field :name, :string

    many_to_many :contacts, Simmer.Contact, join_through: Simmer.Subscription

    timestamps()
  end

  @required_params [:name]
  @optional_params []

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params ++ @optional_params)
    |> validate_required(@required_params)
  end
end
