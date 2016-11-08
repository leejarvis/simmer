defmodule Simmer.List do
  use Simmer.Web, :model

  schema "lists" do
    field :name, :string

    belongs_to :project, Simmer.Project
    many_to_many :contacts, Simmer.Contact, join_through: Simmer.Subscription

    timestamps()
  end

  @required_params [:name]
  @optional_params []

  def changeset(struct, project, params \\ %{}) do
    struct
    |> cast(params, @required_params ++ @optional_params)
    |> put_assoc(:project, project)
    |> validate_required(@required_params)
  end
end
