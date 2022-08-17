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
    question = build_question(generators: %{left: [1], right: [2]})
    assert question.substitutions == [left: 1, right: 2]
  end

  test "a random choice is made from list generators" do
    generators = %{left: Enum.to_list(1..9), right: [0]}
    substitutions = build_question(generators: generators).substitutions
    assert Keyword.fetch!(substitutions, :left) in generators.left
  end

  test "function generators are called" do
    generators = %{left: fn -> 42 end, right: [0]}
    substitutions = build_question(generators: generators).substitutions
    assert Keyword.fetch!(substitutions, :left) == generators.left.()
  end

  test "building creates the question to ask the quiz taker" do
    assert build_question(generators: %{left: [1], right: [2]}).asked == "1 + 2"
  end
end
