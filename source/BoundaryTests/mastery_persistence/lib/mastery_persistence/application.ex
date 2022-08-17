#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule MasteryPersistence.Application do
  use Application

  def start(_type, _args) do
    children = [
      MasteryPersistence.Repo
    ]

    opts = [strategy: :one_for_one, name: MasteryPersistence.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
