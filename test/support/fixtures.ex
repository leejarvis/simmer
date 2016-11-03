defmodule Simmer.Fixtures do
  alias Simmer.Repo
  alias Simmer.Contact
  alias Simmer.List

  def create(schema, params \\ %{})

  def create(:contact, params) do
    contact_params = %{email: "lee@jarvo.io", first_name: "Lee", last_name: "Jarvis"}
    Repo.insert! struct(Contact, Map.merge(contact_params, params))
  end

  def create(:list, params) do
    list_params = %{name: "Newsletter"}
    Repo.insert! struct(List, Map.merge(list_params, params))
  end
end
