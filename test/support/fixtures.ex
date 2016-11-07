defmodule Simmer.Fixtures do
  alias Simmer.Repo
  alias Simmer.Contact
  alias Simmer.List
  alias Simmer.Project

  def create(schema, params \\ %{})

  def create(:contact, params) do
    insert!(Contact,
      %{
        project_id: create(:project).id,
        email:      "lee@jarvo.io",
        first_name: "Lee",
        last_name:  "Jarvis"
      },
      params)
  end

  def create(:list, params) do
    project = create(:project)
    insert!(List, %{project_id: project.id, name: "Newsletter"}, params)
  end

  def create(:project, params) do
    insert!(Project, %{name: "Mailer"}, params)
  end

  defp insert!(struct, default_params, params) do
    attrs = Map.merge(default_params, params)
    Repo.get_by(struct, attrs) || Repo.insert!(struct(struct, attrs))
  end
end
