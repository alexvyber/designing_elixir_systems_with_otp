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

  test "building checks the answer" do
    quiz = build_quiz(
      templates: [template_fields(generators: %{left: [1], right: [2]})]
    )
    |> Quiz.select_question
    
    question = quiz.current_question
    template = question.template
    
    email = "mathy@example.com"
    answer = "3"

    right = Response.new(quiz, template, question, email, answer)
    assert right.correct

    wrong = Response.new(quiz, template, question, email, "wrong")
    refute wrong.correct
  end

  test "a timestamp is added at build time" do
    quiz = 
      build_quiz()
      |> Quiz.select_question 
    
    question = quiz.current_question
    email = "mathy@example.com"
    answer = "3"


    response = Response.new(quiz, question.template, question, email, answer)
    assert %DateTime{ } = response.timestamp
    assert response.timestamp < DateTime.utc_now()
  end
end
