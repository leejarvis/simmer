defmodule Simmer.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Simmer.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import Simmer.Router.Helpers

      alias Simmer.Fixtures

      # The default endpoint for testing
      @endpoint Simmer.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Simmer.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Simmer.Repo, {:shared, self()})
    end

    project = Simmer.Fixtures.project
    changes = Simmer.APIKey.changeset(%Simmer.APIKey{}, %{name: "testing"})
              |> Ecto.Changeset.put_assoc(:project, project)
    api_key = Simmer.Repo.insert!(changes)

    conn = Phoenix.ConnTest.build_conn()
           |> Plug.Conn.put_req_header("authorization", api_key.key)
           |> Plug.Conn.put_req_header("accept", "application/vnd.api+json")
           |> Plug.Conn.put_req_header("content-type", "application/vnd.api+json")

    {:ok, project: project, conn: conn}
  end
end
