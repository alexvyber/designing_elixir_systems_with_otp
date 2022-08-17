#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule QuestionTest do
  use ExUnit.Case
  use QuizBuilders

  test "building chooses substitutions" do
    question = build_question(generators: addition_generators([1], [2]))
    
    assert question.substitutions == [left: 1, right: 2]
  end

  test "function generators are called" do
    generators = addition_generators( fn -> 42 end, [0] )
    substitutions = build_question(generators: generators).substitutions
    
    assert Keyword.fetch!(substitutions, :left) == generators.left.()
  end

  test "building creates asked question text" do
    question = build_question(generators: addition_generators([1], [2]))
    
    assert question.asked == "1 + 2"
  end
  
  test "a random choice is made from list generators" do
    generators = addition_generators(Enum.to_list(1..9), [0])
    
    assert eventually_match(generators, 1)
    assert eventually_match(generators, 9)
  end
  
  def eventually_match(generators, number) do
    Stream.repeatedly(fn ->
      build_question(generators: generators).substitutions
    end)
    |> Enum.find(fn substitution -> 
      Keyword.fetch!(substitution, :left) == number end)
  end
end
