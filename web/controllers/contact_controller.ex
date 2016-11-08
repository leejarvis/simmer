defmodule Simmer.ContactController do
  use Simmer.Web, :controller

  alias Simmer.Contact

  def index(conn, _params) do
    render(conn, "contacts.json", contacts: current_project(conn, :contacts))
  end

  def create(conn, %{"contact" => contact_params}) do
    changeset = Contact.changeset(%Contact{}, current_project(conn), contact_params)

    case Repo.insert(changeset) do
      {:ok, contact} ->
        conn
        |> put_resp_header("location", contact_path(conn, :show, contact))
        |> put_status(:created)
        |> render("contact.json", contact: contact)
      {:error, changeset} -> unprocessable_entity(conn, changeset)
    end
  end

  def show(conn, %{"email" => email}) do
    contact = get_by!(conn, Contact, email: email)
    render(conn, "show.json", contact: contact)
  end

  def update(conn, %{"email" => email, "contact" => contact_params}) do
    contact = get_by!(conn, Contact, email: email)
    changeset = Contact.changeset(contact, current_project(conn), contact_params)

    case Repo.update(changeset) do
      {:ok, contact} ->
        render(conn, "show.json", contact: contact)
      {:error, changeset} -> unprocessable_entity(conn, changeset)
    end
  end

  def delete(conn, %{"email" => email}) do
    get_by!(conn, Contact, email: email) |> Repo.delete!
    send_resp(conn, :no_content, "")
  end
end
