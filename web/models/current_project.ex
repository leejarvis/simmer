defmodule Simmer.CurrentProject do
  alias Simmer.Repo

  @doc """
  Returns the current Simmer.Project stored in `conn` after authorisation.
  """
  def current_project(conn) do
    conn.private.project
  end

  @doc """
  Helper function for fetching associated data from the current project,
  expects the association to be present (e.g. as a `has_many` in
  Simmer.Project).

  ## Examples

      current_project(conn, :contacts)
  """
  def current_project(conn, association) do
    Repo.preload(current_project(conn), association)
    |> Map.fetch!(association)
  end

  @doc """
  Helper function for implementing `Repo.get_by!/2` except scoped
  to the current project. The project will also be preloaded, so
  it expects `struct` to `belong_to` project.

  ## Examples:

      get_by!(conn, Contact, email: "lee@example.com")
  """
  def get_by!(conn, struct, params) do
    params = Enum.into(params, %{})
             |> Map.put(:project_id, current_project(conn).id)

    Repo.get_by!(struct, params)
    |> Repo.preload(:project)
  end

  @doc """
  Helper function for implementing `Repo.get!/2` except scoped
  to the current project. The project will also be preloaded, so
  it expects `struct` to `belong_to` project.

  ## Examples:

      get!(conn, List, 123)
  """
  def get!(conn, struct, id) do
    get_by!(conn, struct, id: id)
  end
end
