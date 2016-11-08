defmodule Simmer.ErrorController do
  import Plug.Conn, only: [put_status: 2, halt: 1]
  import Phoenix.Controller, only: [render: 4]

  @doc """
  Renders a 422 status passing the changeset to the error.json
  template. Halts the plug pipeline.

  ## Examples

      case Repo.insert(changeset) do
        {:ok, struct} ->
          # ...
        {:error, changeset} -> unprocessable_entity(conn, changeset)
  """
  def unprocessable_entity(conn, changeset) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Simmer.ChangesetView, "error.json", changeset: changeset)
    |> halt
  end
end
