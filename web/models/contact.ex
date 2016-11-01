defmodule Simmer.Contact do
  use Simmer.Web, :model

  schema "contacts" do
    field :email,       :string
    field :first_name,  :string
    field :last_name,   :string

    timestamps()
  end

  @required_params [:email]
  @optional_params [:first_name, :last_name]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_params ++ @optional_params)
    |> validate_required(@required_params)
  end

  defimpl Phoenix.Param do
    def to_param(%{email: email}), do: email
  end
end
