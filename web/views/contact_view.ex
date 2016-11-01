defmodule Simmer.ContactView do
  use Simmer.Web, :view

  def render("contact.json", %{contact: contact}) do
    %{
      contact: %{
        email: contact.email,
        first_name: contact.first_name,
        last_name:  contact.last_name
      }
    }
  end
end
