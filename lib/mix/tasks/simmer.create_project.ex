defmodule Mix.Tasks.Simmer.CreateProject do
  use Mix.Task

  @shortdoc "Create a new Simmer.Project"
  def run([project_name]) do
    Mix.Task.run "app.start", []

    project = project(project_name) |> Simmer.Repo.preload(:api_keys)
    api_key = api_key(project)

    Mix.shell.info "`#{project_name}` created with API key `#{api_key.key}`"
  end

  defp project(project_name) do
    case Simmer.Repo.get_by(Simmer.Project, name: project_name) do
      nil -> Simmer.Repo.insert!(%Simmer.Project{name: project_name})
      project -> project
    end
  end

  defp api_key(project) do
    case Enum.at(project.api_keys, 0) do
      nil ->
        Simmer.APIKey.changeset(%Simmer.APIKey{}, %{name: "API key"})
        |> Ecto.Changeset.put_assoc(:project, project)
        |> Simmer.Repo.insert!()
      api_key -> api_key
    end
  end
end
