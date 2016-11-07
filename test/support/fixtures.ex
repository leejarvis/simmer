defmodule Simmer.Fixtures do
  alias Simmer.Repo
  alias Simmer.Contact
  alias Simmer.List
  alias Simmer.Project

  def create(schema, project, params \\ %{})

  def create(project, :contact, params) do
    insert!(Contact,
      %{
        project_id: project.id,
        email:      "lee@jarvo.io",
        first_name: "Lee",
        last_name:  "Jarvis"
      },
      params)
  end

  def create(project, :list, params) do
    insert!(List, %{project_id: project.id, name: "Newsletter"}, params)
  end

  def project(params \\ %{}) do
    insert!(Project, %{name: "Mailer"}, params)
  end

  defp insert!(struct, default_params, params) do
    attrs = Map.merge(default_params, params)
    Repo.get_by(struct, attrs) || Repo.insert!(struct(struct, attrs))
  end
end
