#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule Mastery do
  alias Mastery.Boundary.{QuizSession, QuizManager}
  alias Mastery.Boundary.{TemplateValidator, QuizValidator}
  alias Mastery.Core.Quiz
  
  def build_quiz(fields) do
    with :ok <- QuizValidator.errors(fields),
         :ok <- QuizManager.build_quiz(fields), 
    do: :ok, else: (error -> error)
  end
  
  def add_template(title, fields) do
    with :ok <- TemplateValidator.errors(fields), 
         :ok <- QuizManager.add_template(title, fields), 
    do: :ok, else: (error -> error)
  end
  
  def take_quiz(title, email) do
    with %Quiz{}=quiz <- QuizManager.lookup_quiz_by_title(title), 
         {:ok, _} <- QuizSession.take_quiz(quiz, email) 
    do
      {title, email}
    else
      error -> error
    end
  end
  
  def select_question(name) do
    QuizSession.select_question(name)
  end

  def answer_question(name, answer) do
    QuizSession.answer_question(name,  answer)
  end
end

