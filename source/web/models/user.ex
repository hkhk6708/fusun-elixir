defmodule Fusun.Model.User do
  use Fusun.Web, :model
  import Comeonin.Bcrypt, only: [checkpw: 2]
  
  schema "users" do    
    # Fields
    field :username,        :string, unique: true 
    field :email,           :string, unique: true 
    field :phone,           :string
    field :password,        :string 
    field :firstname,       :string 
    field :lastname,        :string 
    field :role,            :string 
    field :status,          :integer
    timestamps

    # virtual fields
    field :password_unhash,       :string, virtual: true
    field :current_password,      :string, virtual: true
    field :password_unhash_confirmation, :string, virtual: true
  end

  # Static Constants
  @required_fields ~w()
  @optional_fields ~w()

  @roles %{
    admin: "admin",
    user: "user",
  }

  @get_roles %{
    admin: (gettext "Admin"),
    user: (gettext "User")
  }

  def role_admin, do: Map.get(@roles, :admin)
  def role_user, do: Map.get(@roles, :user)

  def role_name(user) do
    Map.get(@get_roles, String.to_atom(user.role))
  end

  def full_name(user) do
    "#{user.firstname} #{user.lastname}"
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:username, min: 1)
    |> validate_length(:email, min: 1)
  end

  def validate_current_password(changeset, field, model, params) do
    current_password = get_field(changeset, field)
    if current_password != nil && checkpw(current_password, model.password), do: changeset, else: add_error(changeset, :current_password, (gettext "does not match current password"))
  end

  defp put_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password_unhash: password_unhash}} ->
        put_change(changeset, :password, encrypt_password(password_unhash))
      _->
        changeset
    end
  end

  defp encrypt_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
