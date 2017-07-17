defmodule Fusun.ImageUploader do
	use CoginiFileStorage
	import Fusun.Gettext

	def virtual_field_postfix() do
		"_image"
	end

	# Whitelist file extensions:
	def validate(filename) do
	~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(filename))
	end

	# Define the default bucket:
	# def default_bucket, do: Application.get_env(:fusun, :default_bucket)
	def default_dir, do: "/upload"
end
