#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule ProctorTest do
  use ExUnit.Case

  alias Mastery.Examples.Math
  alias Mastery.Boundary.QuizSession

  @moduletag capture_log: true

  test "quizzes can be scheduled" do
    quiz = Math.quiz_fields |> Map.put(:title, :timed_addition)
    now = DateTime.utc_now
    email = "student@example.com"

    assert :ok == Mastery.schedule_quiz(
      quiz,
      [Math.template_fields],
      DateTime.add(now, 50, :millisecond),
      DateTime.add(now, 100, :millisecond),
      self()
    )

    refute Mastery.take_quiz(quiz.title, email)


    assert_receive {:started, :timed_addition}
    assert Mastery.take_quiz(quiz.title, email)

    assert_receive {:stopped, :timed_addition}
    assert [ ] == QuizSession.active_sessions_for(quiz.title)
  end
end
