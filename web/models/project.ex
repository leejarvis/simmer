defmodule Simmer.Project do
  use Simmer.Web, :model

  schema "projects" do
    field :name, :string

    has_many :api_keys, Simmer.APIKey
    has_many :lists,    Simmer.List
    has_many :contacts, Simmer.Contact

    timestamps()
  end

  @required_fields [:name]
  @optional_fields []

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
