defmodule Simmer.ListControllerTest do
  use Simmer.ConnCase

  test "GET /lists", %{conn: conn} do
    conn = get(conn, list_path(conn, :index))
    assert json_response(conn, 200) == %{"lists" => []}
  end

  test "POST /lists", %{project: project, conn: conn} do
    conn = post(conn, list_path(conn, :create), %{list: %{name: "Newsletter"}})
    assert json_response(conn, 201) == %{"name" => "Newsletter"}

    project = Repo.preload(project, :lists)
    assert Enum.at(project.lists, 0).name == "Newsletter"
  end

  test "GET /list/:id", %{project: project, conn: conn} do
    list = Fixtures.create(project, :list)
    conn = get(conn, list_path(conn, :show, list))

    assert json_response(conn, 200)["list"]["name"] == list.name
  end
end
