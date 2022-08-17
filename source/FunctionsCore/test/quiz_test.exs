#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule QuizTest do
  use ExUnit.Case
  use QuizBuilders

  test "the next question is randomly selected" do
    quiz = build_quiz()
    %{current_question: %{template: first_template}} = Quiz.select_question(quiz)

    other_template =
      Stream.repeatedly(fn ->
        Quiz.select_question(quiz).current_question.template
      end)
      |> Enum.find(fn other -> other != first_template end)

    assert first_template != other_template
  end

  test "all templates are used before the cycle repeats" do
    quiz = build_quiz()
    new_quiz = Quiz.select_question(quiz)
    first_template = template(new_quiz)

    reset_quiz = Quiz.select_question(new_quiz)
    last_template = template(reset_quiz)

    done_quiz = Quiz.select_question(reset_quiz)
    fresh_template = template(done_quiz)

    assert template(new_quiz) != template(reset_quiz)
    assert fresh_template in [first_template, last_template]
  end

  test "questions are repeated until a user answers mastery in a row" do
    quiz = build_quiz(
      mastery: 2,
      templates: [template_fields(generators: %{left: [1], right: [2]})]
    )
    email = "mathy@example.com"
    answer = "3"

    assert is_nil(
      quiz
      |> Quiz.select_question
      |> answer_question(email, answer)
      |> Quiz.select_question
      |> answer_question(email, "wrong")
      |> Quiz.select_question
      |> answer_question(email, answer)
      |> Quiz.select_question
      |> answer_question(email, answer)
      |> Quiz.select_question
    )
  end

  def answer_question(quiz, email, answer) do
    question = quiz.current_question
    response = Response.new(quiz, question.template, question, email, answer)

    Quiz.answer_question(quiz, response)
  end

  defp template(quiz) do
    quiz.current_question.template
  end
end
