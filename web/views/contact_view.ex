defmodule Simmer.ContactView do
  use Simmer.Web, :view
  use JaSerializer.PhoenixView

  attributes [:email, :first_name, :last_name, :additional_fields]
end
