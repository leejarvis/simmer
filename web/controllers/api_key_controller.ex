defmodule Simmer.APIKeyController do
  use Simmer.Web, :controller

  def index(conn, _params) do
    render(conn, data: current_project(conn, :api_keys))
  end
end
