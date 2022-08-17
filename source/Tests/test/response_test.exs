#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule ResponseTest do
  use ExUnit.Case
  use QuizBuilders

  describe "a right response and a wrong response" do
    setup [:right, :wrong]
    
    test "building responses checks answers", %{right: right, wrong: wrong} do
      assert right.correct
      refute wrong.correct
    end

    test "a timestamp is added at build time", %{right: response} do    
      assert %DateTime{ } = response.timestamp
      assert response.timestamp < DateTime.utc_now()
    end
  end

  defp quiz() do
    fields = template_fields(generators: %{left: [1], right: [2]})
    
    build_quiz()
    |> Quiz.add_template(fields)
    |> Quiz.select_question
  end

  defp response(answer) do
    Response.new(quiz(), "mathy@example.com", answer)
  end

  defp right(context) do
    { :ok, Map.put(context, :right, response("3")) }
  end
  
  defp wrong(context) do
    { :ok, Map.put(context, :wrong, response("2")) }
  end    
end
