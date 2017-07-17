defmodule CoginiFileStorage.Actions do
  defmacro __using__(_) do
    quote do
      def store(args) do
        CoginiFileStorage.Actions.store(__MODULE__, args)
      end

      def url(args) do
        CoginiFileStorage.Actions.url(__MODULE__, args)
      end

      def get_base64(args) do
        CoginiFileStorage.Actions.get_base64(__MODULE__, args)
      end
    end
  end

  # Save to default bucket and default dir
  def store(module, {file}) do
    put(module, file, module.default_dir(), module.default_bucket())
  end

  # Save to default bucket
  def store(module, {file, destination_dir}) do
    put(module, file, destination_dir, module.default_bucket())
  end

  # Save to specific bucket
  def store(module, {file, destination_dir, bucket}) do
    put(module, file, destination_dir, bucket)
  end

  defp put(_, nil, _, _) do
    {:error, :file_not_found}
  end

  defp put(module, file, destination_dir, bucket) when is_binary(file) do
    put(module, %{filename: Path.basename(file), path: file}, destination_dir, bucket)
  end

  defp put(module, file, destination_dir, bucket) when is_map(file) do
    destination_dir = Path.join(["/", "#{destination_dir}"])
    case module.validate(file.filename) do
      true -> module.__storage.put(file, destination_dir, bucket)
      _    -> {:error, :invalid_file}
    end
  end

  defp put(_, _, _, _) do
    {:error, :file_not_found}
  end

  def module

  # Get the url of the file
  def url(module, {path}) do
    url(module, {path, module.default_bucket()})
  end

  def url(module, {nil, bucket}) do
    nil
  end

  def url(module, {path, bucket}) do
    "#{module.__storage.host(bucket)}#{path}"
  end

  def url(_, _) do
    "#"
  end

  # Get base64 data of the file and return
  def get_base64(module, file) when is_binary(file) do
    get_base64(module, %{filename: Path.basename(file), path: file})
  end

  def get_base64(module, file = %{filename: original_filename, path: local_file_path}) do
    case File.read(local_file_path) do
      {:ok, binary} ->
        mime = Plug.MIME.path(original_filename)
        base64_binary = Base.encode64(binary)
        {:ok, "data:#{mime};base64,#{base64_binary}"}
      {:error, _} ->
        {:error, :file_not_read}
    end
  end
end
