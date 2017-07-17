defmodule CoginiFileStorage.S3 do
  # Stream the file and upload to AWS as a multi-part upload
  def put(file = %{filename: original_filename, path: local_file_path}, destination_dir, bucket) do
    try do
      s3_filename = "#{UUID.uuid1}#{Path.extname(original_filename)}"
      s3_path = Path.join(destination_dir, s3_filename)
      
      local_file_path
      |> ExAws.S3.Upload.stream_file()
      |> ExAws.S3.upload(bucket, s3_path, s3_options(file))
      |> ExAws.request()
      |> case do
        # :done -> {:ok, file.file_name}
        {:ok, :done} -> {:ok, original_filename, s3_path}
        {:error, error} -> {:error, error}
      end
    rescue
      e in ExAws.Error ->
        {:error, :invalid_bucket}
    end
  end

  defp virtual_host do
    # Application.get_env(:ex_aws, :virtual_host) || false
    false
  end

  def get_cdn(bucket) do
    #cdn = Map.get(Application.get_env(:ex_aws, :cdns), bucket)
    nil
  end

  def host(bucket) do
    case get_cdn(bucket) do
      nil ->
        s3_config = Application.get_env(:ex_aws, :s3)
        scheme = Map.get(s3_config, :scheme)
        host = Map.get(s3_config, :host)
        case virtual_host do
          true -> "#{scheme}#{bucket}.#{host}"
          _    -> "#{scheme}#{host}/#{bucket}"
        end
      cdn ->
        cdn 
    end
  end

  defp s3_options(file = %{filename: original_filename, path: local_file_path}) do
    [content_type: Plug.MIME.path(original_filename)]
  end

  defp s3_options(original_filename) do
    [content_type: Plug.MIME.path(original_filename)]
  end

  defp s3_options do
    []
  end
end