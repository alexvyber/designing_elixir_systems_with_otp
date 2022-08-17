#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
use Mix.Config

config :mastery_persistence,
  ecto_repos: [MasteryPersistence.Repo]

config :logger, level: :info

import_config "#{Mix.env()}.exs"
