defmodule TestingLiveViewWallaby.QuestionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TestingLiveViewWallaby.Questions` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        text: "some text"
      })
      |> TestingLiveViewWallaby.Questions.create_question()

    question
  end
end
