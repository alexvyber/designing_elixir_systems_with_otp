#---
# Excerpted from "Designing Elixir Systems with OTP",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/jgotp for more book information.
#---
defmodule Mastery.Boundary.QuizManager do
  alias Mastery.Core.Quiz
  use GenServer

  def init(quizzes) when is_map(quizzes) do
    {:ok, quizzes}
  end
  
  def init(_quizzes), do: {:error, "quizzes must be a map"} 

  def start_link(options \\ [ ]) do
    GenServer.start_link(__MODULE__, %{ }, options)
  end

  def build_quiz(manager \\ __MODULE__, quiz_fields) do
    GenServer.call(manager, {:build_quiz, quiz_fields})
  end

  def add_template(manager \\ __MODULE__, quiz_title, template_fields) do
    GenServer.call(manager, {:add_template, quiz_title, template_fields})
  end

  def lookup_quiz_by_title(manager \\ __MODULE__, quiz_title) do
    GenServer.call(manager, {:lookup_quiz_by_title, quiz_title})
  end

  def remove_quiz(manager \\ __MODULE__, quiz_title) do
	  GenServer.call(manager, {:remove_quiz, quiz_title})
	end
	
  def handle_call({:build_quiz, quiz_fields}, _from, quizzes) do
    quiz = Quiz.new(quiz_fields)
    new_quizzes = Map.put(quizzes, quiz.title, quiz)

    {:reply, :ok, new_quizzes}
  end

  def handle_call(
    {:add_template, quiz_title, template_fields},
    _from,
    quizzes
  ) do
    new_quizzes = Map.update!(quizzes, quiz_title, fn quiz ->
      Quiz.add_template(quiz, template_fields)
    end)

    {:reply, :ok, new_quizzes}
  end

  def handle_call({:remove_quiz, quiz_title}, _from, quizzes) do
    new_quizzes = Map.delete(quizzes, quiz_title)
    {:reply, :ok, new_quizzes}
  end

  def handle_call({:lookup_quiz_by_title, quiz_title}, _from, quizzes) do

    {:reply, quizzes[quiz_title], quizzes}
  end
end
