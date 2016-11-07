defmodule Simmer.Authorization do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      [key] -> authorize(conn, key)
      []    -> forbidden(conn)
    end
  end

  def authorize(conn, key) do
    case Simmer.Repo.get_by(Simmer.APIKey, key: key) do
      nil -> forbidden(conn)
      key ->
        project = Simmer.Repo.preload(key, :project).project
        put_private(conn, :project, project)
    end
  end

  def forbidden(conn) do
    conn
    |> put_status(:forbidden)
    |> Phoenix.Controller.render(Simmer.ErrorView, "403.json")
    |> halt
  end

end
