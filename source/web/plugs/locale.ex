defmodule Plug.Locale do
	import Plug.Conn

	def init(_opts) do
		nil
	end

	def call(conn, _opts) do
		case prefered_locale(conn) do
			nil ->
				# Gettext will use default settings, no need to set anything
				Gettext.put_locale(Fusun.Gettext, "zh_tw")
				conn
			locale ->
				Gettext.put_locale(Fusun.Gettext, locale)
				conn
		end
	end

	def set_locale(conn, locale) do
		if not locale in Gettext.known_locales(Fusun.Gettext) do
			# Gettext will use default settings, no need to set anything
			Gettext.put_locale(Fusun.Gettext, "zh_tw")
			conn
		else
			Gettext.put_locale(Fusun.Gettext, locale)
			conn |> put_session(:locale, locale)
		end
	end


	@doc """
	get the prefered locale based on the input locale, session and accept-language request header

	return nil if there's none and :wrong if the params_locale doesn't exist
	"""
	def prefered_locale(conn) do
		cond do
			session_locale(conn) ->
				session_locale(conn)
			req_header_locale(conn) ->
				req_header_locale(conn)
			true ->
				nil
		end
	end

	@doc """
	return if exists an already set location in the session

	"""
	def session_locale(conn) do
		conn.params["locale"] || get_session(conn, :locale)
	end

	@doc """
	match the prefered locale based on the accept_language http request header, and the existing I18n locales
	return nil if none

	"""
	def req_header_locale(conn) do
		accept_language = get_req_header(conn, "accept-language")
		if not Enum.empty?(accept_language) do
			accept_language = List.first(accept_language)
			matches = Regex.scan(~r/[a-z]{2,8}/, accept_language) |> List.flatten
			Enum.find matches, fn(x) -> x in Gettext.known_locales(Fusun.Gettext) end
		end
	end
end