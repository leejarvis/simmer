defmodule Simmer.APIKeyTest do
  use Simmer.ModelCase

  alias Simmer.APIKey

  test "generating keys" do
    cs  = APIKey.changeset(%APIKey{}, %{name: "Test key"})
    key = Repo.insert!(cs)

    assert String.length(key.key) == 32
  end

end
