defmodule Simmer.APIKey do
  use Simmer.Web, :model

  @key_length 32

  schema "api_keys" do
    field :name, :string
    field :key, :string

    belongs_to :project, Simmer.Project

    timestamps()
  end

  @required_fields [:name, :key]
  @optional_fields []

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> put_api_key
    |> validate_required(@required_fields)
  end

  def put_api_key(%Ecto.Changeset{} = cs) do
    put_change(cs, :key, generate_api_key())
  end

  def generate_api_key do
    :crypto.strong_rand_bytes(@key_length)
    |> Base.url_encode64()
    |> binary_part(0, @key_length)
  end

end
