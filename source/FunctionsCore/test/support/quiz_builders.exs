#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule QuizBuilders do
  defmacro __using__(_options) do
    quote do
      alias Mastery.Core.{Template, Response, Quiz}
      import QuizBuilders, only: :functions
    end
  end

  alias Mastery.Core.{Template, Question, Quiz}

  def template_fields(overrides \\ [ ]) do
    single_digits = Enum.to_list(0..9)
    Keyword.merge(
      [
        name: :single_digit_addition,
        category: :addition,
        instructions: "Add the numbers",
        raw: "<%= @left %> + <%= @right %>",
        generators: %{left: single_digits, right: single_digits},
        checker: fn substitutions, answer ->
          left = Keyword.fetch!(substitutions, :left)
          right = Keyword.fetch!(substitutions, :right)
          to_string(left + right) == String.trim(answer)
        end
      ],
      overrides
    )
  end

  def build_question(overrides \\ [ ]) do
    overrides
    |> template_fields
    |> Template.new
    |> Question.new
  end

  def build_quiz(overrides \\ [ ]) do
    double_digits = Enum.to_list(10..99)
    {templates, overrides} =
      Keyword.pop(
        overrides,
        :templates,
        [
          template_fields(),
          template_fields(
            name: :double_digit_addition,
            generators: %{left: double_digits, right: double_digits}
          )
        ]
      )
    quiz_fields = Keyword.merge([title: "Simple Arithmetic"], overrides)
    Enum.reduce(templates, Quiz.new(quiz_fields), fn template, quiz ->
      Quiz.add_template(quiz, template)
    end)
  end
end
