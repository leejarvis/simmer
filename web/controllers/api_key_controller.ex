defmodule Simmer.APIKeyController do
  use Simmer.Web, :controller

  def index(conn, _params) do
    render(conn, "api_keys.json", api_keys: current_project(conn, :api_keys))
  end
end
