defmodule Simmer.ContactView do
  use Simmer.Web, :view

  def render("contacts.json", %{contacts: contacts}) do
    %{contacts: render_many(contacts, __MODULE__, "contact.json")}
  end

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
