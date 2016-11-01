defmodule Simmer.Router do
  use Simmer.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Simmer do
    pipe_through :api

    resources "/contacts", ContactController
  end
end
