defmodule Simmer.ContactController do
  use Simmer.Web, :controller

  alias Simmer.Contact

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
end
