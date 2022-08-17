#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule Counter do
  def start(initial_count) do
    spawn( fn() -> Counter.Server.run(initial_count) end )
  end

  def tick(pid) do
    send pid, {:tick, self()}
  end
  def state(pid) do
    send pid, {:state, self()}
    receive do

      {:count, value} -> value
    end
  end
end
