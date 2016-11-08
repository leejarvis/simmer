defmodule Simmer.ListView do
  use Simmer.Web, :view

  def render("lists.json", %{lists: lists}) do
    %{lists: render_many(lists, __MODULE__, "list.json")}
  end

  def render("show.json", %{list: list}) do
    %{list: render_one(list, __MODULE__, "list.json")}
  end

  def render("list.json", %{list: list}) do
    %{
      name: list.name,
    }
  end
end
