defmodule Simmer.ListController do
  use Simmer.Web, :controller

  alias Simmer.List

  def index(conn, _params) do
    render(conn, "lists.json", lists: current_project(conn, :lists))
  end

  def create(conn, %{"list" => list_params}) do
    changeset = List.changeset(%List{}, current_project(conn), list_params)

    case Repo.insert(changeset) do
      {:ok, list} ->
        conn
        |> put_resp_header("location", list_path(conn, :show, list))
        |> put_status(:created)
        |> render("list.json", list: list)
      {:error, changeset} -> unprocessable_entity(conn, changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list = get!(conn, List, id)
    render(conn, "show.json", list: list)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list      = get!(conn, List, id)
    changeset = List.changeset(list, current_project(conn), list_params)

    case Repo.update(changeset) do
      {:ok, list} ->
        render(conn, "show.json", list: list)
      {:error, changeset} -> unprocessable_entity(conn, changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    get!(conn, List, id) |> Repo.delete!
    send_resp(conn, :no_content, "")
  end
end
