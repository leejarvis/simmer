defmodule Simmer.APIKeyView do
  use Simmer.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :key]
end
