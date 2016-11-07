defmodule Simmer.APIKeyView do
  use Simmer.Web, :view

  def render("api_keys.json", %{api_keys: api_keys}) do
    %{api_keys: render_many(api_keys, __MODULE__, "api_key.json")}
  end

  def render("api_key.json", %{api_key: api_key}) do
    %{
      name: api_key.name,
      key:  api_key.key,
    }
  end
end
