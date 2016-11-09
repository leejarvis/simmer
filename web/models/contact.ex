defmodule Simmer.Contact do
  use Simmer.Web, :model

  @derive {Phoenix.Param, key: :email}

  schema "contacts" do
    field :email,             :string
    field :first_name,        :string
    field :last_name,         :string
    field :additional_fields, :map, default: %{}

    belongs_to :project, Simmer.Project
    many_to_many :lists, Simmer.List, join_through: Simmer.Subscription

    timestamps()
  end

  @required_params [:email]
  @optional_params [:first_name, :last_name, :additional_fields]

  @additional_field_limit 20

  def changeset(struct, project, params \\ %{}) do
    struct
    |> cast(params, @required_params ++ @optional_params)
    |> put_assoc(:project, project)
    |> validate_required(@required_params)
    |> validate_max_count(:additional_fields, @additional_field_limit)
  end

  defp validate_max_count(changeset, field, count) do
    if Enum.count(get_field(changeset, field)) > count do
      add_error(changeset, field, "cannot be more than #{count}")
    else
      changeset
    end
  end
end
