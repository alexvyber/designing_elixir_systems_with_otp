#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule ValidationTest do
  use ExUnit.Case
  alias Mastery.Boundary.QuizValidator

  test "quiz fields with only a title are valid" do
    assert QuizValidator.errors(%{title: "title"}) == :ok
  end

  test "quiz fields without a title are not valid" do
    assert QuizValidator.errors(%{}) == [title: "is required"]
  end

  test "quiz fields without a title and a bad mastery are not valid" do
    expected = [title: "is required", mastery: "must be greater than zero"]
    assert QuizValidator.errors(%{mastery: 0}) == expected
  end

  test "quiz fields of the wrong type are not valid" do
    expected = [nil: "A map of fields is required"]
    assert QuizValidator.errors("invalid") == expected
  end
end
