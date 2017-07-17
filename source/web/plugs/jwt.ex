defmodule Plug.JWT do
  import Plug.Conn
  use Timex

  def init(opts) do 
    opts
  end

  def call(conn, _) do
    jwt = Dict.get(conn.params, "jwt", nil)
    case verify_and_decode_jwt(jwt) do
      {:error, reason} ->
        conn
        |> send_resp(400, reason)
        |> halt
      {:ok, claims} ->
        conn
    end
  end

  defp get_timestamp() do
    Timex.now |> Timex.format!("{ISO:Extended}")
  end

  defp verify_timestamp(timestamp) do
    # case Timex.parse(timestamp, "{ISO:Extended}") do
    #   {:ok, date_time} ->
    #     Timex.diff(Timex.now, date_time, :weeks) == 0 
    #   _ ->
    #     false
    # end
    true
  end

  defp verify_claims(claims) do
    cond do
      is_nil(claims.timestamp) ->
        {:error, "Timestamp not found"}
      !verify_timestamp(claims.timestamp) ->
        {:error, "Token expired"}
      true ->
        {:ok, claims}
    end
  end

  def verify_and_decode_jwt(nil), do: {:error, "Token not found"}
  def verify_and_decode_jwt(""), do: {:error, "Token not found"}
  def verify_and_decode_jwt(jwt) do
    try do    
      case JsonWebToken.verify(jwt, %{key: Application.get_env(:protpms, :app_jwt_key)}) do
        {:ok, claims} ->
          verify_claims(claims)
        _ ->
          {:error, "Cannot decode jwt."}
      end
    rescue
      e ->
        {:error, e}
    end
  end

  def jwt_encode(claims) do
    claims
    |> Map.merge(%{timestamp: get_timestamp()})
    |> JsonWebToken.sign(%{key: Application.get_env(:protpms, :app_jwt_key)})
  end
end