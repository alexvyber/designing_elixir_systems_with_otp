#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule Counter.Server do
  def run(count) do
    new_count = listen(count)
    run(new_count)
  end

  def listen(count) do
    receive do
      {:tick, _pid} -> 
        Counter.Core.inc(count)
      {:state, pid} -> 
        send(pid, {:count, count})
        count
    end
  end
end
