defmodule CoginiFileStorage.Definition do
  defmacro __using__(_) do
    quote do
      def validate(_), do: true
      def default_bucket, do: "storage"
      def default_dir, do: "/"
      def __storage, do: CoginiFileStorage.S3

      defoverridable [validate: 1, __storage: 0, default_bucket: 0, default_dir: 0]
    end
  end
end