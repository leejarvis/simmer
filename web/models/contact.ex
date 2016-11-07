defmodule Simmer.Contact do
  use Simmer.Web, :model

  @derive {Phoenix.Param, key: :email}

  schema "contacts" do
    field :email,       :string
    field :first_name,  :string
    field :last_name,   :string

    belongs_to :project, Simmer.Project
    many_to_many :lists, Simmer.List, join_through: Simmer.Subscription

    timestamps()
  end

  @required_params [:email]
  @optional_params [:first_name, :last_name]

  def changeset(struct, project, params \\ %{}) do
    struct
    |> cast(params, @required_params ++ @optional_params)
    |> put_assoc(:project, project)
    |> validate_required(@required_params)
  end
end
