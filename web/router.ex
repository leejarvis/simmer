defmodule Simmer.Router do
  use Simmer.Web, :router

  pipeline :api do
    plug Simmer.Authorization

    plug :accepts, ["json"]
  end

  scope "/api", Simmer do
    pipe_through :api

    resources "/api_keys", APIKeyController, only: [:index]
    resources "/contacts", ContactController, param: "email"
    resources "/lists",    ListController
  end
end
