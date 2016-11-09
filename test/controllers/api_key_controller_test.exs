defmodule Simmer.APIKeyControllerTest do
  use Simmer.ConnCase

  test "GET /api_keys", %{project: project, conn: conn} do
    conn = get(conn, api_key_path(conn, :index))
    keys = Repo.preload(project, :api_keys).api_keys
           |> Enum.map(fn k -> %{"key" => k.key, "name" => k.name} end)

    assert keys == Enum.map(json_response(conn, 200)["data"], &(&1["attributes"]))
  end
end
