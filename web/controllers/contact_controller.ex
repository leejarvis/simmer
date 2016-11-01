defmodule Simmer.ContactController do
  use Simmer.Web, :controller

  alias Simmer.Contact

  def index(conn, _params) do
    contacts = Repo.all(Contact)
    render(conn, "contacts.json", contacts: contacts)
  end

  def create(conn, %{"contact" => contact_params}) do
    changeset = Contact.changeset(%Contact{}, contact_params)

    case Repo.insert(changeset) do
      {:ok, contact} ->
        conn
        |> put_resp_header("location", contact_path(conn, :show, contact))
        |> put_status(:created)
        |> render("contact.json", contact: contact)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Simmer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"email" => email, "contact" => contact_params}) do
    contact = Repo.get_by!(Contact, email: email)
    changeset = Contact.changeset(contact, contact_params)

    case Repo.update(changeset) do
      {:ok, contact} ->
        render(conn, "contact.json", contact: contact)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Simmer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"email" => email}) do
    Repo.get_by!(Contact, email: email)
    send_resp(conn, :no_content, "")
  end
end
