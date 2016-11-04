defmodule Simmer.ContactView do
  use Simmer.Web, :view

  def render("contacts.json", %{contacts: contacts}) do
    %{contacts: render_many(contacts, __MODULE__, "contact.json")}
  end

  def render("show.json", %{contact: contact}) do
    %{contact: render_one(contact, __MODULE__, "contact.json")}
  end

  def render("contact.json", %{contact: contact}) do
    %{
      email:        contact.email,
      first_name:   contact.first_name,
      last_name:    contact.last_name,
      inserted_at:  contact.inserted_at,
    }
  end
end
