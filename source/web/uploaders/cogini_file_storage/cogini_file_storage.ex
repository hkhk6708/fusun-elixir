defmodule CoginiFileStorage do
  defmacro __using__(_) do
    quote do
      use CoginiFileStorage.Definition
      use CoginiFileStorage.Actions
    end
  end
end