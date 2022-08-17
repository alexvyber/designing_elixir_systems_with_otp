#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule MasteryPersistence.Response do
  use Ecto.Schema
  import Ecto.Changeset
  
  @mastery_fields ~w[quiz_title template_name to email answer correct]a
  @timestamps ~w[inserted_at updated_at]a
  
  schema "responses" do
    field :quiz_title, :string
    field :template_name, :string
    field :to, :string
    field :email, :string
    field :answer, :string
    field :correct, :boolean

    timestamps()
  end

  def record_changeset(fields) do
    %__MODULE__{ }
    |> cast(fields, @mastery_fields ++ @timestamps)
    |> validate_required(@mastery_fields ++ @timestamps)
  end
end
