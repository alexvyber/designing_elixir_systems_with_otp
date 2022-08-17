#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule MasteryPersistence.Repo.Migrations.CreateResponses do
  use Ecto.Migration

  def change do
    create table(:responses) do
      add :quiz_title, :string, null: false
      add :template_name, :string, null: false
      add :to, :text, null: false
      add :email, :string, null: false
      add :answer, :string, null: false
      add :correct, :boolean, null: false

      timestamps()
    end

    create index(:responses, :email)
  end
end