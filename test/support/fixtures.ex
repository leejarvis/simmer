defmodule Simmer.Fixtures do
  alias Simmer.Repo
  alias Simmer.Contact

  def create(:contact, params \\ %{}) do
    contact_params = %{email: "lee@jarvo.io", first_name: "Lee", last_name: "Jarvis"}
    Repo.insert! struct(Contact, Map.merge(contact_params, params))
  end
end
